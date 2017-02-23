# Camfind Storefront

Create an iOS camera app that takes a picture and shows a search results from Shopify similar to [CamFind](https://itunes.apple.com/us/app/camfind-search-qr-reader-price/id595857716?mt=8). 

1. Open the app
* Take a picture
* Submit the image
* Get the “keyword” result
* Use the keyword to search for an item on a Shopify Store
* The search response is a listings from within the app. 


---


# UIX

1. Camera
2. Search Results (Listings View)


---


# App Workflow

A. User takes a picture and sends a POST to [CamFind Image Request API](https://camfind.p.mashape.com/image_requests/)

B. The CamFind API responds with a <token>

C. Using the ```<token>```, the app sends a GET request to [CamFind Image Response API]

```language-powerbash
https://camfind.p.mashape.com/image_responses/<token>
```

D. CamFind API responds back with a:

```language-javascript
 {
  "status": "completed",
  "name": "description of image"
 }
```

E. Using ```"name": "description of image"```,  the app sends another GET request to YQL server. 

```language-bash
var q = "http://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20html%20WHERE%20url%3D%22http%3A%2F%2Fimpctful.com%2Fsearch%3Fx%3D0%26amp%3By%3D0%26amp%3Bq%3D" + keyword + "%22%20and%20xpath%3D'%2F%2F*%5B%40id%3D%22search%22%5D'&format=json&diagnostics=true&callback=?";
```

[Javascript Example](http://jsbin.com/IhawIwO/16/edit)

F. The JSONP results are presented in an iPhone ListView.


---

# Resources


### [Cloudsight](https://market.mashape.com/imagesearcher/cloudsight) (formerly Camfind)

* [Chunking a photo to CamFind](http://blog.frankgrimm.net/2010/11/howto-access-http-message-body-post-data-in-node-js)


### [Yahoo Query Language](http://developer.yahoo.com/yql/)

- [http://developer.yahoo.com/yql/console/](http://developer.yahoo.com/yql/console/)
- [Example of search “glasses”](http://developer.yahoo.com/yql/console/?q=SELECT%20*%20FROM%20html%20WHERE%20url%3D%22http%3A%2F%2Fimpctful.com%2Fsearch%3Fx%3D0%26amp%3By%3D0%26amp%3Bq%3Dglasses%22%20and%20xpath%3D'%2F%2F*%5B%40id%3D%22search%22%5D')


### [Shopify Storefront](http://docs.shopify.com/api/tutorials/creating-a-private-app)

- http://ecommerce.shopify.com/c/shopify-apis-and-technology/t/jsonp-error-151108
- http://ecommerce.shopify.com/c/shopify-discussion/t/get-products-and-collections-from-a-different-domain-via-ajax-64902#comment-105376


### Mashape Info

* http://stackoverflow.com/questions/11589671/serving-http-1-0-responses-with-node-js-unknown-content-length-chunked-transfe


