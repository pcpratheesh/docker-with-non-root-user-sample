package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"net/http"
)

var (
	port = flag.String("port", "8080", "port")
)

func main() {
	flag.Parse()

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		path := r.URL.Path[1:] // remove leading slash
		data, err := ioutil.ReadFile(path)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		w.Write(data)
	})

	fmt.Printf("Starting server on port %s\n", *port)
	err := http.ListenAndServe(":"+*port, nil)
	if err != nil {
		fmt.Printf("Error starting server: %s\n", err)
	}
}
