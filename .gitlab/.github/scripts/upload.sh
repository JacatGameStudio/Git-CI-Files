#file-name: discord_notify.sh
#!/bin/bash


curl 'https://stores.volio.vn/api/apks' \
  -H 'authority: stores.volio.vn' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: vi-VN,vi;q=0.9,en-US;q=0.8,en;q=0.7,zh-CN;q=0.6,zh;q=0.5' \
  -H 'authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9zdG9yZXMudm9saW8udm5cL2FwaVwvbG9naW4iLCJpYXQiOjE2NjE0ODQ4MjUsImV4cCI6MTY2NTA4NDgyNSwibmJmIjoxNjYxNDg0ODI1LCJqdGkiOiJ0QjBDdWMxQWNvdm9FR2cxIiwic3ViIjozMiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.eGD04lQpC5ymDYvi3JAG119cPxFP2i1lCy0BevBtnro' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary3y6fygBNx1SdRkzq' \
  -H 'cookie: _ga_GZMKRD2TW3=GS1.1.1663989795.41.0.1663989796.0.0.0; _ga=GA1.2.33680282.1648801934; mp_7ccb86f5c2939026a4b5de83b5971ed9_mixpanel=%7B%22distinct_id%22%3A%20%22183829858588aa-0b131d93e04fad-13303676-1fa400-18382985859bc3%22%2C%22%24device_id%22%3A%20%22183829858588aa-0b131d93e04fad-13303676-1fa400-18382985859bc3%22%2C%22site_type%22%3A%20%22similarweb%20extension%22%2C%22%24initial_referrer%22%3A%20%22%24direct%22%2C%22%24initial_referring_domain%22%3A%20%22%24direct%22%7D' \
  -H 'origin: https://stores.volio.vn' \
  -H 'referer: https://stores.volio.vn/admin/volio/apk-uploader' \
  -H 'sec-ch-ua: "Google Chrome";v="105", "Not)A;Brand";v="8", "Chromium";v="105"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36' \
  --data-raw $'------WebKitFormBoundary3y6fygBNx1SdRkzq\r\nContent-Disposition: form-data; name="file"; filename="Magisk-v25.1.apk"\r\nContent-Type: application/vnd.android.package-archive\r\n\r\n\r\n------WebKitFormBoundary3y6fygBNx1SdRkzq--\r\n' \
  --compressed