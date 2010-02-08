package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.text.twitter.Extractor;

    public class ExtractorTest extends TestCase
    {
        public function ExtractorTest(meth:String)
        {
            super(meth);
        }

        public static function suite():TestSuite
        {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new ExtractorTest("testReply"));
            ts.addTest(new ExtractorTest("testMention"));
            ts.addTest(new ExtractorTest("testHashtag"));
            return ts;
        }

        public function testReply():void
        {
            var extractor:Extractor = new Extractor();
            var extracted:String = extractor.extractReplyScreenname("@user reply");
            assertEquals("Failed to extract reply at the start", "user", extracted);

            var extracted2:String = extractor.extractReplyScreenname(" @user reply");
            assertEquals("Failed to extract reply with leading space", "user", extracted2);
        }

        public function testMention():void
        {
            var extractor:Extractor = new Extractor();
            var extracted:Array = extractor.extractMentionedScreennames("@user mention");
            assertEquals("Failed to extract mention at the beginning", "user", extracted[0]);

            var extracted2:Array = extractor.extractMentionedScreennames(" @user mention");
            assertEquals("Failed to extract mention with leading space", "user", extracted2[0]);

            var extracted3:Array = extractor.extractMentionedScreennames("mention @user here");
            assertEquals("Failed to extract mention in mid text", "user", extracted3[0]);

            var extracted4:Array = extractor.extractMentionedScreennames("mention @user1 here and @user2 here");
            assertEquals("Failed to extract multiple mentioned user", "user1", extracted4[0]);
            assertEquals("Failed to extract multiple mentioned user", "user2", extracted4[1]);
        }

        public function testHashtag():void
        {
            var extractor:Extractor = new Extractor();
            var extracted:Array = extractor.extractHashtags("#hashtag mention");
            assertEquals("matched count should be 1 for beginning hashtag", 1, extracted.length);
            assertEquals("Failed to extract hashtag at the beginning", 'hashtag', extracted[0]);

            var extracted2:Array = extractor.extractHashtags(" #hashtag mention");
            assertEquals("matched count should be 1 with leading space", 1, extracted2.length);
            assertEquals("Failed to extract hashtag with leading space", "hashtag", extracted2[0]);

            var extracted3:Array = extractor.extractHashtags("mention #hashtag here");
            assertEquals("matched count should be 1 in mid text", 1, extracted3.length);
            assertEquals("Failed to extract hashtag in mid text", "hashtag", extracted3[0]);

            var extracted4:Array = extractor.extractHashtags("text #hashtag1 #hashtag2");
            assertEquals("matched count should be 2", 2, extracted4.length);
            assertEquals("Failed to extract multiple hashtags", "hashtag1", extracted4[0]);
            assertEquals("Failed to extract multiple hashtags", "hashtag2", extracted4[1]);
        }
    }

}
