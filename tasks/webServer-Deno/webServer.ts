const server = Deno.listen({ port: 8000 });
const encoder = new TextEncoder();
const decoder = new TextDecoder();

console.log("tcp server listening on port 8000");

const connections: Deno.Conn[] = [];

for await (const connection of server) {
  connections.push(connection);
  handle_connection(connection);
}

async function handle_connection(connection: Deno.Conn) {
  let buffer = new Uint8Array(1024);
  await connection.read(buffer);
  let test = decoder.decode(buffer);
  let result = test.split(/\r?\n/);
  let request_line = result[0];
  let start_line_parts = request_line.split(' ')
  if (start_line_parts[1] == '/'){
    await connection.write(encoder.encode('HTTP/1.0 200 OK\r\nContent-Type:text/html\r\n\r\n'))
    await FileHandler('index.html',connection)
  }else{
    await connection.write(encoder.encode('HTTP/1.0 200 OK\r\n\r\n'))
    await FileHandler(start_line_parts[1],connection)
  }
  connection.close();
}


async function FileHandler(path: string,connection: Deno.Conn){
  const file = await Deno.open('.'+path);
  const buf = new Uint8Array(65555);
  while(1){
    const numberOfBytesRead = await Deno.read(file.rid, buf);
    if(numberOfBytesRead){
    await connection.write(buf.slice(0,numberOfBytesRead));
    }else{
      break;
    }

  }
  Deno.close(file.rid);
}
