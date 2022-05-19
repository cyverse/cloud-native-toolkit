package main

import (
	"log"
	"net/http"

	"github.com/google/uuid"
	"github.com/gorilla/mux"

	"github.com/kelseyhightower/envconfig"

	"github.com/nats-io/nats.go"
)

type ConfigInfo struct {
	NatsURL         string `default:"nats://nats:4222" split_words:"true"`
	NatsSubjectBase string `default:"hydrogen.test" split_words:"true"`
	HttpPort        string `default:"8080" split_words:"true"`
}

var Config ConfigInfo
var GitBranch string
var GitCommit string

func main() {

	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/", rootHandler)
	router.HandleFunc("/workflow1", createWorkflow1).Methods("POST")
	router.HandleFunc("/workflow2", createWorkflow2).Methods("POST")

	log.Println("Starting http server on " + Config.HttpPort)
	http.ListenAndServe(":"+Config.HttpPort, router)
	log.Println("Terminating http server")
}

func init() {
	log.Println("initializing api")
	err := envconfig.Process("", &Config)
	if err != nil {
		log.Fatal(err.Error())
	}

	// TODO: check smoke test connection to nats here

	log.Println("commit info = " + GitBranch + "/" + GitCommit)
	log.Println("nats url = " + Config.NatsURL)
	log.Println("nats subject base = " + Config.NatsSubjectBase)
}

func rootHandler(w http.ResponseWriter, r *http.Request) {
	log.Println("Received a request on /")
	w.Header().Add("Content-Type", "text/html")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("ok " + GitBranch + "/" + GitCommit))
}

func createWorkflow1(w http.ResponseWriter, r *http.Request) {
	log.Println("Received a request on /workflow1 with data: message = " + r.FormValue("message"))

	tid := uuid.New()

	message := "{"
	message += "\"message\":" + "\"" + r.FormValue("message") + "\","
	message += "\"tid\":" + "\"" + tid.String() + "\""
	message += "}"

	nc, _ := nats.Connect(Config.NatsURL) // really should check, but hey, it's a POC
	nc.Publish(Config.NatsSubjectBase+".workflow1", []byte(message))
	defer nc.Close()

	w.Header().Add("Content-Type", "text/html")
	w.WriteHeader(http.StatusAccepted)
	w.Write([]byte("Accepted, transaction id = " + tid.String()))
}

func createWorkflow2(w http.ResponseWriter, r *http.Request) {
	log.Println("Received a request on /workflow2 with data: message = " + r.FormValue("message"))

	tid := uuid.New()

	message := "{"
	message += "\"message\":" + "\"" + r.FormValue("message") + "\","
	message += "\"tid\":" + "\"" + tid.String() + "\""
	message += "}"

	nc, _ := nats.Connect(Config.NatsURL) // really should check, but hey, it's a POC
	nc.Publish(Config.NatsSubjectBase+".workflow2", []byte(message))
	defer nc.Close()

	w.Header().Add("Content-Type", "text/html")
	w.WriteHeader(http.StatusAccepted)
	w.Write([]byte("Accepted, transaction id = " + tid.String()))
}
