use std::ffi::CString;
use std::net::UdpSocket;
use std::os::raw::{c_char, c_int, c_long, c_uint, c_ulong, c_void};
use std::ptr;
use std::thread;

/* ===== ALSA FFI ===== */

#[repr(C)]
struct snd_pcm_t;
#[repr(C)]
struct snd_pcm_hw_params_t;

const SND_PCM_STREAM_PLAYBACK: c_int = 0;
const SND_PCM_STREAM_CAPTURE: c_int = 1;
const SND_PCM_ACCESS_RW_INTERLEAVED: c_int = 3;
const SND_PCM_FORMAT_S16_LE: c_int = 2;

extern "C" {
    fn snd_pcm_open(
        pcm: *mut *mut snd_pcm_t,
        name: *const c_char,
        stream: c_int,
        mode: c_int,
    ) -> c_int;

    fn snd_pcm_hw_params_malloc(p: *mut *mut snd_pcm_hw_params_t) -> c_int;
    fn snd_pcm_hw_params_any(pcm: *mut snd_pcm_t, p: *mut snd_pcm_hw_params_t) -> c_int;
    fn snd_pcm_hw_params_set_access(pcm: *mut snd_pcm_t, p: *mut snd_pcm_hw_params_t, v: c_int) -> c_int;
    fn snd_pcm_hw_params_set_format(pcm: *mut snd_pcm_t, p: *mut snd_pcm_hw_params_t, v: c_int) -> c_int;
    fn snd_pcm_hw_params_set_channels(pcm: *mut snd_pcm_t, p: *mut snd_pcm_hw_params_t, v: c_uint) -> c_int;
    fn snd_pcm_hw_params_set_rate(pcm: *mut snd_pcm_t, p: *mut snd_pcm_hw_params_t, v: c_uint, dir: c_int) -> c_int;
    fn snd_pcm_hw_params(pcm: *mut snd_pcm_t, p: *mut snd_pcm_hw_params_t) -> c_int;

    fn snd_pcm_readi(pcm: *mut snd_pcm_t, buf: *mut c_void, size: c_ulong) -> c_long;
    fn snd_pcm_writei(pcm: *mut snd_pcm_t, buf: *const c_void, size: c_ulong) -> c_long;
}

/* ===== CONFIG ===== */

const SAMPLE_RATE: u32 = 8000;
const CHANNELS: u32 = 1;
const FRAMES: usize = 160; // 20 ms

unsafe fn open_pcm(stream: c_int) -> *mut snd_pcm_t {
    let name = CString::new("default").unwrap();
    let mut pcm: *mut snd_pcm_t = ptr::null_mut();

    if snd_pcm_open(&mut pcm, name.as_ptr(), stream, 0) < 0 {
        std::process::abort();
    }

    let mut params: *mut snd_pcm_hw_params_t = ptr::null_mut();
    snd_pcm_hw_params_malloc(&mut params);
    snd_pcm_hw_params_any(pcm, params);
    snd_pcm_hw_params_set_access(pcm, params, SND_PCM_ACCESS_RW_INTERLEAVED);
    snd_pcm_hw_params_set_format(pcm, params, SND_PCM_FORMAT_S16_LE);
    snd_pcm_hw_params_set_channels(pcm, params, CHANNELS);
    snd_pcm_hw_params_set_rate(pcm, params, SAMPLE_RATE, 0);
    snd_pcm_hw_params(pcm, params);

    pcm
}

/* ===== MAIN ===== */

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 5 {
        return;
    }

    let listen = &args[2];
    let peer = &args[4];

    let socket = UdpSocket::bind(listen).unwrap();
    socket.connect(peer).unwrap();
    let recv_socket = socket.try_clone().unwrap();

    unsafe {
        let capture = open_pcm(SND_PCM_STREAM_CAPTURE);
        let playback = open_pcm(SND_PCM_STREAM_PLAYBACK);

        thread::spawn(move || {
            let mut buf = [0i16; FRAMES];
            loop {
                let bytes = recv_socket.recv(
                    std::slice::from_raw_parts_mut(buf.as_mut_ptr() as *mut u8, FRAMES * 2)
                ).unwrap();

                snd_pcm_writei(
                    playback,
                    buf.as_ptr() as *const c_void,
                    (bytes / 2) as c_ulong,
                );
            }
        });

        let mut buf = [0i16; FRAMES];
        loop {
            let frames = snd_pcm_readi(
                capture,
                buf.as_mut_ptr() as *mut c_void,
                FRAMES as c_ulong,
            );

            if frames > 0 {
                socket.send(
                    std::slice::from_raw_parts(buf.as_ptr() as *const u8, frames as usize * 2)
                ).unwrap();
            }
        }
    }
}
