package main 

import "fmt"
import "net"
import "log"
import "bufio"
import "os"


func main(){
	ln, err := net.Listen("tcp", ":8081")
if err != nil {

	fmt.Println(err)
}

for {
	conn, err := ln.Accept()
	if err != nil {
		log.Print(err)
	}

	go handler(conn)

}

}


func removeClient(conn net.Conn) {
	conn.Close()
}

func handler(conn net.Conn) {

	errorChan := make(chan error)
	dataChan := make(chan []byte)

	go readWrapper(conn, dataChan, errorChan)
	data := <-dataChan
	_ = data
	//fmt.Println(string(data))
	// b := []byte("HTTP/1.1 200 OK Hello, World!")
	conn.Write([]byte("HTTP/1.0 200 OK\r\nContent-Type:image/png\r\n\r\n"))
	go ReadFile(conn)
	

   

}

func readWrapper(conn net.Conn, dataChan chan []byte, errorChan chan error) {
	for {
		buf := make([]byte, 65538)
		reqLen, err := conn.Read(buf)
		if err != nil {
			errorChan <- err
			return
		}
		dataChan <- buf[:reqLen]
	}

}


func ReadFile(conn net.Conn) {
	defer removeClient(conn)

   
    f, err := os.Open("peng.png")

    if err != nil {
        log.Fatal(err)
    }


    reader := bufio.NewReader(f)
    buf := make([]byte, 555)

    for {

		n, err := reader.Read(buf)

        if err != nil {
            break
        }
		conn.Write(buf[:n])


	}

}
