use std::io::prelude::*;
use std::net::TcpListener;
use std::net::TcpStream;
use std::fs;
use webServer::ThreadPool;

fn main() {
    let listener = TcpListener::bind("127.0.0.1:9100").unwrap();
    let pool = ThreadPool::new(4);

    for stream in listener.incoming() {
        let stream = stream.unwrap();

        pool.execute(|| {
            handle_connection(stream);
        });
    }

    println!("Shutting down.");
}

fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 5000];
    stream.read(&mut buffer).unwrap();

    let get = b"GET /peng.png HTTP/1.0\r\n";
    let (status_line, filename) = if buffer.starts_with(get) {
      ("HTTP/1.0 200 OK\r\n\r\n", "index.html")
    }else {
      ("HTTP/1.0 404 NOT FOUND\r\n\r\n", "index.html")
    };

    let data = fs::read("peng.png").expect("Unable to read file");
    let response = format!("{}", status_line);

    stream.write(response.as_bytes()).unwrap();
    stream.write(&data);

    stream.flush().unwrap();
}
