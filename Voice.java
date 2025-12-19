import javax.sound.sampled.*;
import java.net.*;

public class Voice {

    static final int BUFFER = 1024;

    public static void main(String[] args) throws Exception {

        if (args.length != 3) return;

        boolean server = args[0].equals("server");
        String ip = args[1];
        int port = Integer.parseInt(args[2]);

        AudioFormat format = new AudioFormat(
                8000.0f,
                16,
                1,
                true,
                false
        );

        TargetDataLine mic = AudioSystem.getTargetDataLine(format);
        SourceDataLine speaker = AudioSystem.getSourceDataLine(format);

        mic.open(format);
        speaker.open(format);

        mic.start();
        speaker.start();

        DatagramSocket socket = new DatagramSocket(server ? port : 0);
        InetAddress addr = InetAddress.getByName(ip);

        byte[] buf = new byte[BUFFER];

        new Thread(() -> {
            try {
                while (true) {
                    int n = mic.read(buf, 0, buf.length);
                    DatagramPacket p = new DatagramPacket(buf, n, addr, port);
                    socket.send(p);
                }
            } catch (Exception e) {}
        }).start();

        while (true) {
            DatagramPacket p = new DatagramPacket(buf, buf.length);
            socket.receive(p);
            speaker.write(p.getData(), 0, p.getLength());
        }
    }
}
