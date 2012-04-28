
server {
        listen       80;
        server_name  cms.com www.cms.com;
        access_log   /var/log/nginx/www.cms.com.access.log;
        location / {
        root   /web/website/www.cms.com/www;
        index  index.html index.htm index.php;
        }
        location ~ \.php$ {
            root           /web/website/www.cms.com/www;
            fastcgi_pass   unix:/var/run/fpm/cms;
            fastcgi_index  index.php;
            include        fastcgi.conf;
        }
        location ~ /\.ht {
            deny  all;
        }
	location /status {
	stub_status on;
	access_log   off;
	}
}
