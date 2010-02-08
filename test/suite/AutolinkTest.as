package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.text.twitter.Autolink;

    public class AutolinkTest extends TestCase
    {
        public function AutolinkTest(meth:String)
        {
            super(meth);
        }

        public static function suite():TestSuite
        {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new AutolinkTest("testAutolink"));
            return ts;
        }

        public function testAutolink():void
        {
            var linker:Autolink = new Autolink();
            assertEquals("This has a <a href=\"http://twitter.com/search?q=%23hashtag\" title=\"#hashtag\" class=\"tweet-url hashtag\" rel=\"nofollow\">#hashtag</a>", linker.autoLinkHashtags("This has a #hashtag"));
            var linker2:Autolink = new Autolink();
            linker2.isNoFollow = false;
            assertEquals("This has a <a href=\"http://twitter.com/search?q=%23hashtag\" title=\"#hashtag\" class=\"tweet-url hashtag\">#hashtag</a>", linker2.autoLinkHashtags("This has a #hashtag"));
            'This has a <a href="http://twitter.com/search?q=%23hashtag" title="#hashtag" class="tweet-url hashtag"rel="nofollow">#hashtag</a>'

            assertEquals('hey, this is good, <a href="http://example.org/path" rel="nofollow">http://example.org/path</a> take a look.', linker.autoLinkURLs("hey, this is good, http://example.org/path take a look."));


            assertEquals('Hey, @<a class="tweet-url username" href="http://twitter.com/username" rel="nofollow">username</a>.', linker.autoLinkUsernamesAndLists("Hey, @username."));
        }
    }

}
