import java.io.*;
import java.net.*;

public class App {
    public static void main(String[] args) throws Exception {
        ServerSocket server = new ServerSocket(8080);
        System.out.println("Server started on port 8080");

        while (true) {
            Socket socket = server.accept();
            OutputStream out = socket.getOutputStream();

            String response = "HTTP/1.1 200 OK\r\n\r\nHello DevOps Running 🚀";
            out.write(response.getBytes());
            out.flush();

            socket.close();
        }
    }
}