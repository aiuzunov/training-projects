const encoder = new TextEncoder();
const decoder = new TextDecoder();

const listener = Deno.listen({ port: 8080 });

console.log("listening on 0.0.0.0:8080");
for await (const conn of listener) {
  const buf = new Uint8Array(1024);
  await conn.read(buf);
  await conn.write(encoder.encode('TEST'))
  conn.close();
}
