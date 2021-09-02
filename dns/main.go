package main

import (
	"context"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/cloudflare/cloudflare-go"
)

func main() {
	// 	expected := {
	// 		calibre.internal.veverka.net 100.74.66.105
	// cdn.veverka.net 68.131.109.254
	// dns.veverka.net 192.168.1.69
	// external.veverka.net 68.131.109.254
	// lan.veverka.net 192.168.1.51
	// plex.veverka.net 192.168.1.111
	// psql.internal.veverka.net 100.74.66.105
	// qnap.veverka.net 192.168.1.43
	// unifi.veverka.net 192.168.1.6
	// veverka.net 185.199.111.153
	// veverka.net 185.199.110.153
	// veverka.net 185.199.109.153
	// veverka.net 185.199.108.153
	// 	}

	currentIP := getIPAddress()
	fmt.Println(currentIP)

	// Construct a new API object
	api, err := cloudflare.NewWithAPIToken(os.Getenv("CF_API_TOKEN"))
	if err != nil {
		log.Fatal(err)
	}

	log.Println("CONNECTED")

	// Fetch the zone ID
	zoneID, err := api.ZoneIDByName("veverka.net")
	if err != nil {
		log.Fatal(err)
	}

	var records []cloudflare.DNSRecord

	rr := cloudflare.DNSRecord{}
	var errs error

	records, errs = api.DNSRecords(context.Background(), zoneID, rr)
	if err != nil {
		log.Fatalf("Failed to fetch DNS records: %v", errs)
	}

	// api.CreateDNSRecord(context.Background(), zoneID, cloudflare.DNSRecord{)

	// // DNSRecord represents a DNS record in a zone.
	// type DNSRecord struct {
	// 	ID         string      `json:"id,omitempty"`
	// 	Type       string      `json:"type,omitempty"`
	// 	Name       string      `json:"name,omitempty"`
	// 	Content    string      `json:"content,omitempty"`
	// 	Proxiable  bool        `json:"proxiable,omitempty"`
	// 	Proxied    *bool       `json:"proxied,omitempty"`
	// 	TTL        int         `json:"ttl,omitempty"`
	// 	Locked     bool        `json:"locked,omitempty"`
	// 	ZoneID     string      `json:"zone_id,omitempty"`
	// 	ZoneName   string      `json:"zone_name,omitempty"`
	// 	CreatedOn  time.Time   `json:"created_on,omitempty"`
	// 	ModifiedOn time.Time   `json:"modified_on,omitempty"`
	// 	Data       interface{} `json:"data,omitempty"` // data returned by: SRV, LOC
	// 	Meta       interface{} `json:"meta,omitempty"`
	// 	Priority   *uint16     `json:"priority,omitempty"`
	// }

	file, _ := json.MarshalIndent(records, "", " ")

	_ = ioutil.WriteFile("records.json", file, 0644)

	for _, record := range records {
		if record.Type == "A" {
			fmt.Println(record.Name, record.Content)
		}
		// fmt.Printf("%v: Name: %v / Content: %v\n", record.Type, record.Name, record.Content)
	}
}

func getIPAddress() string {
	url := "https://ifconfig.me"
	client := http.Client{
		Timeout: time.Second * 2, // Timeout after 2 seconds
	}
	req, err := http.NewRequest(http.MethodGet, url, nil)
	if err != nil {
		log.Fatal(err)
	}
	res, getErr := client.Do(req)
	if getErr != nil {
		log.Fatal(getErr)
	}
	if res.Body != nil {
		defer res.Body.Close()
	}
	body, readErr := ioutil.ReadAll(res.Body)
	if readErr != nil {
		log.Fatal(readErr)
	}
	return string(body)
}
