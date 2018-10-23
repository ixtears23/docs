

- 방법
  - HttpClient
  - HttpURLConnection
  
---
  
### sample 예외처리는 제외   

~~~java

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
~~~
