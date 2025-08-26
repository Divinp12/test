use std::process::{Command, Stdio};
use std::thread;
use std::time::Duration;

fn main() {

println!("adicionando espelho brasileiro");
let status1 = Command::new("sh")
.arg("-c")
.arg(r#"echo 'Server=https://mirror.ufscar.br/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist"#)
.stdout(Stdio::null())
.stderr(Stdio::null())
.status()
.expect("algo deu errado ao adicionar espelho brasileiro");
if status1.success() {
println!("sucesso");
thread::sleep(Duration::from_secs(3));
let _ = Command::new("clear")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
}



println!("sobscrevendo arquivo pacman.conf");
let status2 = Command::new("sh")
.arg("-c")
.arg(r#"echo '[options]
Architecture=auto
CheckSpace
ParallelDownloads=1
SigLevel=Required DatabaseOptional
LocalFileSigLevel=Optional
[core]
Include=/etc/pacman.d/mirrorlist
[extra]
Include=/etc/pacman.d/mirrorlist
[multilib]
Include=/etc/pacman.d/mirrorlist' > /etc/pacman.conf"#)
.stdout(Stdio::null())
.stderr(Stdio::null())
.status()
.expect("algo deu errado ao sobscrever arquivo pacman.conf");
if status2.success() {
println!("sucesso");
let _ = Command::new("sleep")
.arg("3")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
let _ = Command::new("clear")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
}



println!("atualizando repositorios");
let status3 = Command::new("pacman")
.arg("-Sy")
.arg("--noconfirm")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status()
.expect("algo deu errado ao atualizar repositorios");
if status3.success() {
println!("sucesso");
let _ = Command::new("sleep")
.arg("3")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
let _ = Command::new("clear")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
}



println!("formatando 1 disco rigido valido");
let status4 = Command::new("sh")
.arg("-c")
.arg(r#"if dd if=/dev/zero of=/dev/nvme0n1p bs=64M && \
parted /dev/nvme0n1p mklabel gpt && \
parted /dev/nvme0n1p mkpart ESP fat32 1MiB 1025MiB && \
parted /dev/nvme0n1p set 1 esp on && \
parted /dev/nvme0n1p mkpart primary ext4 1025MiB 30721MiB && \
parted /dev/nvme0n1p mkpart primary ext4 30721MiB 100% && \
partprobe && \
mkfs.fat -F32 /dev/nvme0n1p1 && \
mkfs.ext4 -F /dev/nvme0n1p2 && \
mkfs.ext4 -F /dev/nvme0n1p3 && \
mount /dev/nvme0n1p2 /mnt && \
mkdir /mnt/boot && \
mkdir /mnt/boot/EFI && \
mkdir /mnt/home && \
mount /dev/nvme0n1p1 /mnt/boot/EFI && \
mount /dev/nvme0n1p3 /mnt/home
else
dd if=/dev/zero of=/dev/sda bs=64M && \
parted /dev/sda mklabel gpt && \
parted /dev/sda mkpart ESP fat32 1MiB 1025MiB && \
parted /dev/sda set 1 esp on && \
parted /dev/sda mkpart primary ext4 1025MiB 30721MiB && \
parted /dev/sda mkpart primary ext4 30721MiB 100% && \
partprobe && \
mkfs.fat -F32 /dev/sda1 && \
mkfs.ext4 -F /dev/sda2 && \
mkfs.ext4 -F /dev/sda3 && \
mount /dev/sda2 /mnt && \
mkdir /mnt/boot && \
mkdir /mnt/boot/EFI && \
mkdir /mnt/home && \
mount /dev/sda1 /mnt/boot/EFI && \
mount /dev/sda3 /mnt/home
fi"#)
.stdout(Stdio::null())
.stderr(Stdio::null())
.status()
.expect("algo deu errado ao formatar 1 disco rigido valido");
if status4.success() {
println!("sucesso");
let _ = Command::new("sleep")
.arg("3")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
let _ = Command::new("clear")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
}



println!("instalando pacotes do sistema");
let status5 = Command::new("pacstrap")
.arg("/mnt")
.arg("--noconfirm")
.arg("base")
.arg("base-devel")
.arg("linux")
.arg("linux-firmware")
.arg("linux-headers")
.arg("networkmanager")
.arg("sudo")
.arg("git")
.arg("fastfetch")
.arg("mesa")
.arg("plasma")
.arg("wayland")
.arg("lib32-wayland")
.arg("xorg-xwayland")
.arg("foot")
.arg("pulseaudio")
.arg("pavucontrol")
.arg("grub-efi-x86_64")
.arg("efibootmgr")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status()
.expect("algo deu errado ao instalar pacotes do sistema");
if status5.success() {
println!("sucesso");
let _ = Command::new("sleep")
.arg("3")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
let _ = Command::new("clear")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
}
        
        else {
        eprintln!("falha na atualização");
    }
}
