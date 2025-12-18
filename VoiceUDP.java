import javax.sound.sampled.*;
import java.net.*;

public class VoiceUDP {

    public static void main(String[] args) throws Exception {

        if (args.length != 3) return;

        boolean isServer = args[0].equals("server");
        String ip = args[1];
        int port = Integer.parseInt(args[2]);

        AudioFormat format = new AudioFormat(
                8000.0f,
                16,
                1,
                true,
                false
        );

        DataLine.Info micInfo = new DataLine.Info(TargetDataLine.class, format);
        DataLine.Info spkInfo = new DataLine.Info(SourceDataLine.class, format);

        TargetDataLine mic = (TargetDataLine) AudioSystem.getLine(micInfo);
        SourceDataLine spk = (SourceDataLine) AudioSystem.getLine(spkInfo);

        mic.open(format);
        spk.open(format);

        mic.start();
        spk.start();

        DatagramSocket socket = new DatagramSocket(isServer ? port : 0);
        InetAddress address = InetAddress.getByName(ip);

        byte[] buffer = new byte[512];

        if (!isServer) {
            socket.send(new DatagramPacket(new byte[1], 1, address, port));
        }

        while (true) {

            mic.read(buffer, 0, buffer.length);
            socket.send(new DatagramPacket(buffer, buffer.length, address, port));

            DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
            socket.receive(packet);
            spk.write(packet.getData(), 0, packet.getLength());
        }
    }
}
