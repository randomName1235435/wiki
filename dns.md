dns

was invented for replacing host files in  1980s

current standards:
RFC 1034 und RFC 1035
formerly RFC 882 und RFC 883

common explanation:
service for mapping from (domain)names to ip adresses
(works like a phonebook)

when a computer cant find the dns in its cache is ask a resolver server of the next level (usually its isp)
if the resolver cant find it, it will send it to next level (usually a rootserver )

DNS clients accept the first answer they get from a DNS server, even if that answer is "that domain does not exist". DNS clients do not keep asking other servers hoping for better luck.
  

It seems like you re referring to the DNS (Domain Name System) hierarchy, which involves multiple levels of organization. While DNS itself doesn't have a strict hierarchical structure with exactly 13 levels, it does have components that can be organized into levels. Here's a breakdown:

Root Level (.): At the top of the hierarchy is the root level, denoted by a dot (.). It is the starting point for DNS resolution.

Top-Level Domains (TLDs): These are the next level down from the root. TLDs are the extensions like .com, .org, .net, .gov, .edu, etc.

Second-Level Domains: Below the TLDs are the second-level domains. These are the names registered by individuals or organizations directly under a TLD. For example, in example.com, "example" is the second-level domain.

Third-Level Domains and Beyond: Subdomains can continue to be created, leading to further levels in the hierarchy. For instance, in subdomain.example.com, "subdomain" is a third-level domain.

13 sets of root dns server:
A Verisign, Inc. (a.gtld-servers.net)
B USC-ISI (b.gtld-servers.net)
C Cogent Communications (c.gtld-servers.net)
D University of Maryland (d.gtld-servers.net)
E NASA (e.gtld-servers.net)
F Internet Systems Consortium, Inc. (f.gtld-servers.net)
G US DoD (g.gtld-servers.net)
H ARL (h.gtld-servers.net)
I Netnod (i.gtld-servers.net)
J Verisign, Inc. (j.gtld-servers.net)
K RIPE NCC (k.gtld-servers.net)
L ICANN (l.gtld-servers.net)
M WIDE Project (m.gtld-servers.net)

> these are organized by 12 different organisations and support top level domains
each set hat their own unique ip adress

> current ip adresses:
A Verisign, Inc. (a.gtld-servers.net): 192.5.6.30, 2001:503:a83e::2:30
B USC-ISI (b.gtld-servers.net): 192.33.4.12, 2001:503:231d::2:30
C Cogent Communications (c.gtld-servers.net): 192.26.92.30, 2001:503:83eb::30
D University of Maryland (d.gtld-servers.net): 199.7.91.13, 2001:500:2d::d
E NASA (e.gtld-servers.net): 192.203.230.10
F Internet Systems Consortium, Inc. (f.gtld-servers.net): 192.5.5.241, 2001:500:2f::f
G US DoD (g.gtld-servers.net): 192.112.36.4
H ARL (h.gtld-servers.net): 198.97.190.53, 2001:500:1::53
I Netnod (i.gtld-servers.net): 192.36.148.17, 2001:7fe::53
J Verisign, Inc. (j.gtld-servers.net): 192.58.128.30, 2001:503:c27::2:30
K RIPE NCC (k.gtld-servers.net): 193.0.14.129, 2001:7fd::1
L ICANN (l.gtld-servers.net): 199.7.83.42, 2001:500:3::42
M WIDE Project (m.gtld-servers.net): 202.12.27.33, 2001:dc3::35

authoritive nameserver knows everything about a domain

A "root server set" refers to a collection of root DNS servers that collectively serve as the authoritative starting point for DNS resolution on the Internet. These servers are responsible for 
answering queries about the root zone of the Domain Name System (DNS), which contains information about the top-level domains (TLDs) such as .com, .org, .net, and so on.

Root server sets consist of several individual root DNS servers, distributed worldwide and managed by different organizations. These servers are designated by letters from 
A to M and are maintained by various entities globally. Each letter corresponds to a specific set of root DNS servers.

The purpose of having multiple root DNS servers within a set is to ensure redundancy and reliability. DNS queries are distributed among these servers to handle the immense 
volume of queries received from DNS resolvers across the Internet. This redundancy helps in ensuring the stability and availability of DNS services, even in the event of server failures or network issues.

usually the rootserver dont know the ip adress of the queried address but knows where to send the reoslver to find the ip adress. so the root server will direct the resolver to top level domain server (TLD) for the specified adress.
so the resolver will now ask the tld server for the ip adress for the queried adress.

the tld stores the adress information for a top level domains such as .com,.net etc.
the TLD server dont know the specific adress of queried adress but knows the authoritative name server (its task is to know the authorivie )
                                                                                           
                                                                                             
                                                                                             
      ┌────────┐                  ┌──────────┐               ┌────────────┐                  
      │        │                  │          │               │            │                  
      │ Client ├──────────────────┤ Resolver ├───────────────┤ Rootserver │                  
      │        │                  │          │               │            │                  
      └────────┘                  └─────┬────┘               └────────────┘                  
                                        │                                                    
                                        │                                                    
                                        │                                                    
                                        │                                                    
                                        │                                                    
                                        │                                                    
                                        │                                                    
                                        │               ┌──────────────────────┐             
                                        │               │                      │             
                                        └───────────────┤Topleveldomain server │             
                                                        │                      │             
                                                        └──────────────────────┘      


Flowchart for google.com:                                                                                                                              
                                                                                                                              
                                                                                                                              
         Client                Resolver              Rootserver             TLDserver      Authoritative Nameserver           
           │                      │                      │                      │                      │                      
           │ask IP for google.com │                      │                      │                      │                      
           ├─────────────────────►│                      │                      │                      │                      
           │                      │                      │                      │                      │                      
           │                      │ ask TLD for .com     │                      │                      │                      
           │                      ├─────────────────────►│                      │                      │                      
           │                      │                      │                      │                      │                      
           │                      │                      │                      │                      │                      
           │                      │     TLD for .com     │                      │                      │                      
           │                      │◄─────────────────────┤                      │                      │                      
           │                      │                      │                      │                      │                      
           │                      │                      │                      │                      │                      
           │                      │            ask IP for google.com            │                      │                      
           │                      ├──────────────────────┬─────────────────────►│                      │                      
           │                      │                      │                      │                      │                      
           │                      │                      │                      │                      │                      
           │                      │            Authoritative Nameserver         │                      │                      
           │                      │◄─────────────────────┬──────────────────────┤                      │                      
           │                      │                      │                      │                      │                      
           │                      │                      │                      │                      │                      
           │                      │              ask IP adress for google       │                      │                      
           │                      ├──────────────────────┬──────────────────────┼─────────────────────►│                      
           │                      │                      │                      │                      │                      
           │                      │                      │                      │                      │                      
           │                      │                   here is the ip friendo :> │                      │                      
           │                      │◄─────────────────────┬──────────────────────┼──────────────────────┤                      
           │                      │                      │                      │                      │                      
           │                      │                      │                      │                      │                      
           │   send back the ip   │                      │                      │                      │                      
           │◄─────────────────────┤                      │                      │                      │                      
           │                      │                      │                      │                      │                      
           │                      │                      │                      │                      │                      
           │                      │                      │                      │                      │                      
           ▼                      ▼                      ▼                      ▼                      ▼                      
                                                                                                                              
                                                                                                                              
dns records

hirachy of dns server:
    ┌────────────┐                                               
    │ Rootserver │                                               
    └──┬─────────┘                                               
       │    ┌──────────────────────┐                              
       └───►│ ToplevelDomainServer │                              
            └────────┬─────────────┘                              
                     │       ┌────────────────────┐             
                     └──────►│ AuthorityNameServer│             
                             └────────────────────┘     

Rootserver (. domain):
TOP 13.
Toplevel: 
knows the Authorityserver of ToplevelDomain (.com, .net, .org/ ..)
AuthorityNameServer:
Know everything of a domain

in authoritative name server hast a zone file:
this file contains dns records
types:
(ttl : time to live - time til next update)
(domain names are read right to left [subdomain.secondleveldomain.topleveldomain.rootdomain -> example.com[.] -> .= rootdomain; .com = topleveldomain; example = secondleveldomain; {www. = subdomain} ])
(www. is a common subdomain)


type    | name              | ipadress              | TTL  | 
--------|-------------------|-----------------------|------|
A       | example.com       | 12.34.56.78           | 7200 |
AAAA    | example.com       | FF:FF:FF:FF:FF:FF:0   | 7200 |
CNAME   | www.example.com   | example.com           | 7200 |


A-Record - IPv4 Adress
AAAA-Record - IPv6 Adress
CName-Record - Canonicalname Adress - resolves a domain or subdomain to another doman name (alias for another domain name )

------------------------------------------------------------------------------------------------------------------------------

Subdomains are used for different services of same server using same ipadress
sample:
type    | name              | ipadress              | TTL  | 
--------|-------------------|-----------------------|------|
CNAME   | ftp.example.com   | example.com           | 7200 |
so when users type that dns in their browser they will get the ip of example.com, but the webserver will direct it wo the ftp service
> CNAME records are similar to A records but the difference is that A records will resolve domain names to ip adresses while CNAMES resolve domain names to domain names

MX Records -  Mail exchange records - is used for email
type    |PRIOTIRY   | name          | Host                  | TTL  | 
--------|-----------|---------------|-----------------------|------|
MX      |   10      | exmaple.com   | mail1.example.com     | 7200 |

> mx records points to the server where emails should be delivered for that domain name
Example: mail to xxx@exmaple.com -> the mail transfer agent (MTA) will query the mx records for exmaple.com beacuase its looking for email server and the dns will respond with the mail server
> MX records witll have generally 2 records one for primary and for secondary along with priority numbers; the lower ones overrides the higher ones

> soa records  - start of authority - stores administrative informations about dns zone
exmaples:
type     |MNANE               | RNAME             | SERIAL      | RETRY  | TTL  | 
---------|--------------------|-------------------|-------------|--------|------|
SOA      |   ns1.example1.com | admin.example.com | 510025      | 60     | 7200 |

dns zone:
DNS zones are essentially portions of the domain name system (DNS) namespace that are managed by specific administrators or organizations. They are used to divide a larger domain into smaller, more manageable sections. Each zone is typically associated with one or more domain names and contains the DNS records for those domains.
(manage purpose)

MNAME - primary name server
RNAME - email adress of the amdin for the zone (dot after toplevel and domainname represents the @)
SERIAL - represents a version in the zone (when an update happens in the zone the serial will change)

zone is a section of domain name space that a certain administrator has been delegated control over
Here are some key points about DNS zones:
Administrative Boundaries: DNS zones serve as administrative boundaries, allowing different entities to manage their own DNS records without interfering with others. For example, a company might have one zone for its public-facing website and another for its internal network.
Authority: Each DNS zone has its own authoritative name servers responsible for storing and serving the DNS records for the domain(s) within that zone. These name servers are configured with the DNS records for the domain(s) they are authoritative for.
Zone Files: DNS zones are typically configured using zone files, which contain the DNS records for the domain(s) within the zone. These records include information such as IP addresses (A records), mail server addresses (MX records), alias records (CNAME), and more.
Delegation: DNS zones can be delegated to different name servers, allowing organizations to distribute the management of their DNS infrastructure as needed. This is often done by specifying the authoritative name servers for a zone in the parent zone's DNS records.
Hierarchy: DNS zones follow a hierarchical structure, with each zone forming part of the larger DNS namespace. For example, the top-level domain (TLD) ".com" is a zone, and within it, there can be multiple subzones representing individual domains.
Dynamic Updates: In some cases, DNS zones support dynamic updates, allowing DNS records to be modified or added automatically through dynamic DNS protocols. This is particularly useful for systems where IP addresses may change frequently, such as dynamic IP assignments for DHCP clients.

dons zones allow a domain namespace such as axample.com to be divides into differen sections

> ns records  - name server - provide the name of the authoriative name server within a domain
(name server contains all dns records necessary for users to find a computer or server in a local network or server)
(final authority in a DNS hirachy)

exmaples:
type     |VALUE               | NAME              | TTL  | 
---------|--------------------|-------------------|------|
NS       |   ns1.example1.com | example.com       | 7200 |

-> usually 2 name servers - primary, secondary

> SRV records  - service records - points to a server and port

exmaples:
type     |PRIOTIRY | SERVICE             | PORT | NAME        | WEIGHT | TTL   |
---------|---------|---------------------|------|-------------|--------|-------|
SRV      | 10      | service.example.com | 999  | example.com | 0      |  7200 |

> SRV records  - service records - points to a server and port

exmaples:
type     |PRIOTIRY | SERVICE             | PORT | NAME        | WEIGHT | TTL   |
---------|---------|---------------------|------|-------------|--------|-------|
SRV      | 10      | service.example.com | 999  | example.com | 0      |  7200 |

dont really work for browsers tho cause:
SRV records are generally only useful if you're actually programming an application to query them. By default, browsers don't query them, so they cannot be used to remap the standard ports.


> PTR records - pointer records - reverse of an A/AAAA records - resolves ip adresses to domain names

exmaples:
type     | IP ADRESS      | NAME        | TTL   |
---------|----------------|-------------|-------|
PTR      | 12.34.56.78    | example.com | 7200  |

PTR are attached to email and are used to prevent spam

> TXT records - text records - misc about a domain
(come times contact information)

exmaples:
type     | NAME           | VALUE            | TTL   |
---------|----------------|------------------|-------|
TXT      | example.com    | sample text info | 7200  |


reverse DNS - from ip to dns 








