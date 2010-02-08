package org.coderepos.text.twitter
{
    public class Patterns
    {
        private static const RESERVED_ACTION_WORDS:Array = [
            "twitter",
            "lists",
            "retweet",
            "retweets",
            "following",
            "followings",
            "flollower",
            "flollowers",
            "with_friend",
            "with_friends",
            "statuses",
            "status",
            "activity",
            "favourites",
            "favourite",
            "favorite",
            "favorites",
        ];

        public static const HASHTAG_CHARACTERS:String = "[a-z0-9_\u00c0-\u00d6\u00d8-\u00f6\u00f8-\u00ff]"

        private static const URL_VALID_PRECEEDING_CHARS:String = "(?:[^/\"':!=]|^|\\:)";
        private static const URL_VALID_DOMAIN:String = "(?:[\\.-]|[^\\.\\,\"\\'\\?\\!\\;\\:])+\\.[a-z]{2,}(?::[0-9]+)?";
        private static const URL_VALID_URL_PATH_CHARS:String = "[a-z0-9!\\*'\\(\\);:&=\\+\\$/%#\\[\\]\\-_\\.,~]";
        private static const URL_VALID_URL_PATH_ENDING_CHARS:String = "[a-z0-9\\)=#/]";
        private static const URL_VALID_URL_QUERY_CHARS:String = "[a-z0-9!\\*'\\(\\);:&=\\+\\$/%#\\[\\]\\-_\\.,~]";
        private static const URL_VALID_URL_QUERY_ENDING_CHARS:String = "[a-z0-9_&=#]";

        public static const VALID_URL:String = "("
                + "(" + URL_VALID_PRECEEDING_CHARS + ")"
                + "("
                    + "(https?://|www\\.)"
                    + "(" + URL_VALID_DOMAIN + ")"
                    + "(/" + URL_VALID_URL_PATH_CHARS + "*"
                        + URL_VALID_URL_PATH_ENDING_CHARS + "?)?"
                    + "(\\?" + URL_VALID_URL_QUERY_CHARS + "*"
                        + URL_VALID_URL_QUERY_ENDING_CHARS + ")?"
                + ")"
            + ")";

        public static const AUTO_LINK_HASHTAGS:String = "(^|[^0-9A-Z&/]+)(#|\uFF03)([0-9A-Z_]*[A-Z_]+" + HASHTAG_CHARACTERS + "*)";
        public static const AUTO_LINK_HASHTAGS_GROUP_BEFORE:int = 1;
        public static const AUTO_LINK_HASHTAGS_GROUP_HASH:int   = 2;
        public static const AUTO_LINK_HASHTAGS_GROUP_TAG:int    = 3;

        public static const AUTO_LINK_USERNAMES_OR_LISTS:String = "([^a-z0-9_]|^)([@\uFF20]+)([a-z0-9_]{1,20})(/[a-z][a-z0-9\\x80-\\xFF-]{0,79})?";
        public static const AUTO_LINK_USERNAMES_OR_LIST_GROUP_BEFORE:int   = 1;
        public static const AUTO_LINK_USERNAMES_OR_LIST_GROUP_AT:int       = 2;
        public static const AUTO_LINK_USERNAMES_OR_LIST_GROUP_USERNAME:int = 3;
        public static const AUTO_LINK_USERNAMES_OR_LIST_GROUP_LIST:int     = 4;

        public static const VALID_URL_GROUP_BEFORE:int = 2;
        public static const VALID_URL_GROUP_URL:int    = 3;

        public static const EXTRACT_MENTIONS:String = "(^|[^a-z0-9_])[@\uFF20]([a-z0-9_]{1,20})(?!@)";
        public static const EXTRACT_MENTIONS_GROUP_BEFORE:int   = 1;
        public static const EXTRACT_MENTIONS_GROUP_USERNAME:int = 2;

        public static const EXTRACT_REPLY:String = "^(?:[" + Spaces.getCharacterClass() + "])*[@\uFF20]([a-z0-9_]{1,20}).*";
        public static const EXTRACT_REPLY_GROUP_USERNAME:int = 1;
    }
}
