Objective
===

Create an iOS camera app that takes a picture and shows a search results from Shopify similar to CamFind. 

1. Open the app
2. Take a picture
3. Submit the image
4. Get the “keyword” result
5. Use the keyword to search for an item on a Shopify Store
6. The search response is a listings from within the app. 


UIX
-
1. Camera
2. Search Results (Listings View)


App Workflow
-
1. User takes a picture and sends a POST to [CamFind Image Request API](https://camfind.p.mashape.com/image_requests/)

2. The CamFind API responds with a <token>

3. Using the <token>, the app sends a GET request to [CamFind Image Response API](https://camfind.p.mashape.com/image_responses/<token>)

4. CamFind API responds back with a:
<pre>
 {
  "status": "completed",
  "name": "description of image"
 }
</pre>

5. Using "name": "description of image",  the app sends another GET request to YQL server. 
<pre>
 var q = "http://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20html%20WHERE%20url%3D%22http%3A%2F%2Fimpctful.com%2Fsearch%3Fx%3D0%26amp%3By%3D0%26amp%3Bq%3D" + keyword + "%22%20and%20xpath%3D'%2F%2F*%5B%40id%3D%22search%22%5D'&format=json&diagnostics=true&callback=?";
</pre>

 [Javascript Example](http://jsbin.com/IhawIwO/16/edit)

6. The JSONP results are presented in an iPhone ListView.


Resources
-

Mashape.com

<pre>
 Username: mojotojo
 Password: p@ssword
 Testing Key: WwvoXA8VZ73TfJafX3nvuKBZ0JaQBtnV
</pre>


Yahoo Query Language

- [http://developer.yahoo.com/yql/](http://developer.yahoo.com/yql/)
- [http://developer.yahoo.com/yql/console/](http://developer.yahoo.com/yql/console/)
- [Example of search “glasses”](http://developer.yahoo.com/yql/console/?q=SELECT%20*%20FROM%20html%20WHERE%20url%3D%22http%3A%2F%2Fimpctful.com%2Fsearch%3Fx%3D0%26amp%3By%3D0%26amp%3Bq%3Dglasses%22%20and%20xpath%3D'%2F%2F*%5B%40id%3D%22search%22%5D')


Shopify Info

- http://docs.shopify.com/api/tutorials/creating-a-private-app
- http://ecommerce.shopify.com/c/shopify-apis-and-technology/t/jsonp-error-151108
- http://ecommerce.shopify.com/c/shopify-discussion/t/get-products-and-collections-from-a-different-domain-via-ajax-64902#comment-105376


Mashape Info

- Chunking a photo to CamFind: http://blog.frankgrimm.net/2010/11/howto-access-http-message-body-post-data-in-node-js/
- http://stackoverflow.com/questions/11589671/serving-http-1-0-responses-with-node-js-unknown-content-length-chunked-transfe

