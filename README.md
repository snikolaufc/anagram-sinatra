# Anagram web service

Sinatra based web service application which returns anagrams for requested words.
By default it uses dictionary file from (https://github.com/dwyl/english-words) repository.

## Local installation
1. Clone this repository
2. Within cloned repository location run:
```bash
   bundle install
```
3. Then run webserver by:
```bash
   rackup
```

## Usage
Application works as simple restful, just call 
```
GET localhost:9292/<list-of-words>
```
This should return anagram matches for a given list of words.

Example:
```bash
curl localhost:9292/blog,post 
```
should return:
```bash
{"blog":["glob"],"post":["opts","stop"]}
```

## Further improvements

This is a basic implementation which has some downsides:
 - Dictionary file is loaded in memory and is transformed every time server is starting.
 - It is not possible to extend dictionary, without editing text file and restarting server.
 
Possible solutions
 - One of the solutions would be writing separate rake / bash task to processing text file and
  storing intermediate data. This would reduce app start time, as it would only load preprocessed data, 
  but would not solve problem with extensibility.
 - More complex but scalable solution might be using in memory data store as Redis.   
