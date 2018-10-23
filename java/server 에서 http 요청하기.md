

# server에서 http요청하는 방법

- HttpClient  
- HttpURLConnection
  
---
  
  
> 아주 간단한 sample 코드  
> 예외처리, close resource 제외  

- CloseableHttpClient
  - RequestBuilder  
  - ContentType: application/xml 

```java

  import java.net.MalformedURLException;
  import java.net.URISyntaxException;
  import java.io.IOException;

  import org.apache.http.impl.client.CloseableHttpClient;
  import org.apache.http.impl.client.HttpClients;
  import org.apache.http.client.methods.RequestBuilder;
  import java.nio.charset.Charset;
  import java.net.URI;
  import org.apache.http.client.methods.HttpUriRequest;
  import org.apache.http.HttpEntity;
  import org.apache.http.util.EntityUtils;

  
  public SiteVO siteSearch() throws MalformedURLException, URISyntaxException, IOException {
        SiteVO result = new SiteVO();

        CloseableHttpClient httpclient = HttpClients.custom().build();
        RequestBuilder requestBuilder = RequestBuilder.get();
        requestBuilder.setCharset(Charset.forName("UTF-8"));
        requestBuilder.setUri(new URI(String.format("http://site.co.kr")));
        requestBuilder.setHeader("Content-type", "application/xml");
        
        requestBuilder.addParameter("key", "value");

        HttpUriRequest uriRequest = requestBuilder.build();
        HttpEntity entity = httpclient.execute(uriRequest).getEntity();

        if (entity.isStreaming()) {
            String requestBody = EntityUtils.toString(entity, Charset.forName("UTF-8"));
            result = new Gson().fromJson(requestBody, siteVO.class);
        }
        
        return result;
  }
```

- CloseableHttpClient
  - MultipartEntityBuilder  
  - ContentType: application/octet-stream  

~~~java

  public SiteRegistVO siteRegist(HashMap<String, Object> params) throws MalformedURLException, URISyntaxException, IOException, Exception {
  
        SiteRegistVO result = new SiteRegistVO();
  
        MultipartEntityBuilder multipartEntityBuilder = MultipartEntityBuilder.create();
        multipartEntityBuilder.addTextBody("_method", "PUT", ContentType.TEXT_PLAIN.withCharset("UTF-8"));

        for (Entry<String, Object> iterable_element : params.entrySet()) {
            if (String.valueOf(iterable_element.getValue()) != null && !"".equalsIgnoreCase(String.valueOf(iterable_element.getValue()))
            && !"null".equalsIgnoreCase(String.valueOf(iterable_element.getValue()))) {
                multipartEntityBuilder.addTextBody(iterable_element.getKey(), String.valueOf(iterable_element.getValue()),
                ContentType.TEXT_PLAIN.withCharset("UTF-8"));
            }
        }
        
        File dir = new File(String.format("%s%s", "fileRoot", "fileRoute"));
        byte[] fileData;
        
        if (dir.isDirectory()) {
            fileData = fileToByte(new File(String.format("%s%s%s", "fileRoot", "fileRoute", "fileName")));
        }
        
        
        multipartEntityBuilder.addBinaryBody("fileData", fileData, ContentType.create("application/octet-stream"),
        URLEncoder.encode("originFileName", "UTF-8"));
        
        CloseableHttpClient http = HttpClients.createDefault();
        
        HttpPost post = new HttpPost();
        post.setEntity(multipartEntityBuilder.build());
        post.setURI(new URI(String.format("%s%s/%s/%s", "http://siteRegist.co.kr", "/resource", "/id", "/key")));
        CloseableHttpResponse response = http.execute(post);
        
        HttpEntity entity = response.getEntity();
        String requestBody = EntityUtils.toString(entity, Charset.forName("UTF-8"));
        result = new Gson().fromJson(requestBody, SiteRegistVO.class);
        return result;
        
  }
~~~
