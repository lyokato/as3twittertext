package org.coderepos.text.twitter
{
    public class Extractor
    {
        public function Extractor()
        {

        }

        public function extractMentionedScreennames(text:String):Array // Vector.<String>
        {
            if (text==null)
                return null;
            return extractList(Patterns.EXTRACT_MENTIONS, text, Patterns.EXTRACT_MENTIONS_GROUP_USERNAME);
        }

        public function extractReplyScreenname(text:String):String
        {
            if (text==null)
                return null;

            var pattern:RegExp = new RegExp(Patterns.EXTRACT_REPLY, "i");
            var matched:Object = pattern.exec(text);
            if (matched != null) {
                return matched[Patterns.EXTRACT_REPLY_GROUP_USERNAME];
            } else {
                return null;
            }
        }

        public function extractURLs(text:String):Array // Vector.<String>
        {
            if (text==null)
                return null;
            return extractList(Patterns.VALID_URL, text, Patterns.VALID_URL_GROUP_URL);
        }

        public function extractHashtags(text:String):Array // Vector.<String>
        {
            if (text==null)
                return null;
            return extractList(Patterns.AUTO_LINK_HASHTAGS, text, Patterns.AUTO_LINK_HASHTAGS_GROUP_TAG);
        }

        public function extractList(patternSrc:String, text:String, groupNumber:int):Array // Vector.<String>
        {
            var extracted:Array = [];
            var pattern:RegExp = new RegExp(patternSrc, "gi");
            var result:Object = pattern.exec(text);
            while (result != null) {
                extracted.push(result[groupNumber]);
                result = pattern.exec(text);
            }
            return extracted;
        }
    }
}
