package com.example.goinmull;

import android.app.Activity;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {
    private WebView myWebView;
    private String url = "http://webdev.iptime.org:8080/kgy/initialpage.html";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        myWebView = (WebView) findViewById(R.id.webView);
        myWebView.getSettings().setJavaScriptEnabled(true);
        myWebView.loadUrl(url);
        myWebView.setWebChromeClient(new WebChromeClient());
        myWebView.setWebViewClient(new WebViewClientClass());

    }

    BackPressCloseHandler backPressCloseHandler = new BackPressCloseHandler(this);
    @Override
    public void onBackPressed(){
        if(myWebView.getUrl().equalsIgnoreCase("http://webdev.iptime.org:8080/kgy/initialpage.html")
                ||myWebView.getUrl().equalsIgnoreCase("http://webdev.iptime.org:8080/kgy/modeselect.html")){
            backPressCloseHandler.onBackPressed();

        }
        else if((!myWebView.getUrl().equalsIgnoreCase("http://webdev.iptime.org:8080/kgy/modeselect.html")
                &&!myWebView.getUrl().equalsIgnoreCase("http://webdev.iptime.org:8080/kgy/initialpage.html"))
                &&myWebView.canGoBack()){
            myWebView.goBack();
        }
    }
    public class BackPressCloseHandler{
        private long backKeyPressedTime = 0;
        private Toast toast;
        private Activity activity;

        public BackPressCloseHandler(Activity context){
            this.activity = context;
        }
        public void onBackPressed(){
            if(System.currentTimeMillis()>backKeyPressedTime+2000){
                backKeyPressedTime = System.currentTimeMillis();
                showGuide();
                return;

            }
            if(System.currentTimeMillis() <= backKeyPressedTime +2000){
                activity.finish();
                toast.cancel();
            }
        }
        public void showGuide(){
            toast = Toast.makeText(activity, "뒤로 한번 더 누르시면 종료됩니다", Toast.LENGTH_SHORT);
            toast.show();

        }
    }
    private class WebViewClientClass extends WebViewClient {

        public boolean shouldOverriderUrlLoading(WebView view, String url){
            view.loadUrl(url);
            return true;
        }
    }
}
