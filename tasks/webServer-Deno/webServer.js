const encoder = new TextEncoder();
const decoder = new TextDecoder();

const listener = Deno.listen({ port: 8080 });

console.log("listening on 0.0.0.0:8080");
for await (const conn of listener) {
  const buf = new Uint8Array(1024);
  await conn.read(buf);
  await conn.write(encoder.encode('HTTP/1.0 200 OK\r\n\r\n'))
  const file = await Deno.open("./discord-0.0.12.deb");
  await Deno.copy(file, conn);
  file.close();
  conn.close();
}

// for await (const conn of listener) {
//   const buf = new Uint8Array(1024);
//   await conn.read(buf);
//   await conn.write(encoder.encode('HTTP/1.0 200 OK\r\nContent-Type:image/png\r\n\r\n'))
//   const file = await Deno.open("./peng.png");
//   await Deno.copy(file, conn);
//   file.close();
//   conn.close();
// }
