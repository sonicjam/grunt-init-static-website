/**
 * Social button BFFs (modified)
 *
 * http://www.phpied.com/social-button-bffs/
 * http://t32k.me/mol/log/social-button-bffs/
 * http://www.aaronpeters.nl/blog/why-loading-third-party-scripts-async-is-not-good-enough
 *
 * Load this script before `</body>` like:
 *
 *   <script src="./socials.js"></script>
 *
 *
 * Facebook:
 * https://developers.facebook.com/docs/reference/javascript/
 *
 *   <div class="fb-like" data-send="false" data-layout="button_count" data-width="280"></div>
 *
 *
 * Google +1:
 * https://developers.google.com/+/web/+1button/
 *
 *   <div class="g-plusone" data-size="small"></div>
 *
 *
 * LINE:
 * http://media.line.naver.jp/howto/ja/
 *
 *   <span><script>new jp.naver.line.media.LineButton({"pc":false,"lang":"ja","type":"a"});</script></span>
 *
 *
 * mixi:
 * http://developer.mixi.co.jp/connect/mixi_plugin/favorite_button/spec/
 * http://developer.mixi.co.jp/connect/mixi_plugin/mixi_check/spec_mixi_check/
 * http://developer.mixi.co.jp/connect/mixi_plugin/pagefollow_button/spec/
 *
 *   <div data-plugins-type="mixi-favorite" data-service-key="..."></div>
 *   <a href="http://mixi.jp/share.pl" class="mixi-check-button" data-key="...">mixiチェック</a>
 *   <div data-plugins-type="mixi-page-follow" data-service-key="..."></div>
 *
 *
 * Twitter Buttons:
 * https://twitter.com/about/resources/buttons
 *
 *   <a href="https://twitter.com/share" class="twitter-share-button" data-lang="ja">Tweet</a>
 *
 */

(function (w, d, s) {
  function go() {
    var js, fjs = d.getElementsByTagName(s)[0],
    load = function (url, id) {
      if (d.getElementById(id)) {return;}
      js = d.createElement(s); js.src = url; js.id = id;
      fjs.parentNode.insertBefore(js, fjs);
    };

    // Facebook
    w.fbAsyncInit = function() {
      // init the FB JS SDK
      FB.init({
        appId: 'YOUR_APP_ID',
        channelUrl: '//WWW.YOUR_DOMAIN.COM/channel.html',
        status: true,
        xfbml: true
      });

      // Additional initialization code such as adding Event Listeners goes here
    };

    // Google +1
    w.___gcfg = {lang: 'ja'};

    load('//connect.facebook.net/ja_JP/all.js', 'fbjssdk');
    load('https://apis.google.com/js/plusone.js', 'gplus1js');
    //load('//media.line.naver.jp/js/line-button.js?v=20130508', 'linejs')
    load('//static.mixi.jp/js/plugins.js#lang=ja', 'mixipjs')
    load('//static.mixi.jp/js/share.js', 'mixisjs')
    load('//platform.twitter.com/widgets.js', 'tweetjs');
  }
  if (w.addEventListener) { w.addEventListener("load", go, false); }
  else if (w.attachEvent) { w.attachEvent("onload",go); }
})(window, document, 'script');
