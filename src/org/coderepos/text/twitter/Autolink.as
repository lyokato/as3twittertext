package org.coderepos.text.twitter
{
    public class Autolink
    {
        public static const DEFAULT_URL_CLASS:String         = "tweet-url";
        public static const DEFAULT_LIST_CLASS:String        = "list-slug";
        public static const DEFAULT_USERNAME_CLASS:String    = "username";
        public static const DEFAULT_HASHTAG_CLASS:String     = "hashtag";
        public static const DEFAULT_USERNAME_URL_BASE:String = "http://twitter.com/";
        public static const DEFAULT_LIST_URL_BASE:String     = "http://twitter.com/";
        public static const DEFAULT_HASHTAG_URL_BASE:String  = "http://twitter.com/search?q=%23";
        public static const NO_FOLLOW_HTML_ATTRIBUTE:String  = " rel=\"nofollow\"";

        protected var _urlClass:String;
        protected var _listClass:String;
        protected var _usernameClass:String;
        protected var _hashtagClass:String;
        protected var _usernameUrlBase:String;
        protected var _listUrlBase:String;
        protected var _hashtagUrlBase:String;
        protected var _noFollow:Boolean;

        public function Autolink()
        {
            _urlClass        = DEFAULT_URL_CLASS;
            _listClass       = DEFAULT_LIST_CLASS;
            _usernameClass   = DEFAULT_USERNAME_CLASS;
            _hashtagClass    = DEFAULT_HASHTAG_CLASS;
            _usernameUrlBase = DEFAULT_USERNAME_URL_BASE;
            _listUrlBase     = DEFAULT_LIST_URL_BASE;
            _hashtagUrlBase  = DEFAULT_HASHTAG_URL_BASE;
            _noFollow        = true;
        }

        public function get urlClass():String
        {
            return _urlClass;
        }

        public function set urlClass(klass:String):void
        {
            _urlClass = klass;
        }

        public function get listClass():String
        {
            return _listClass;
        }

        public function set listClass(klass:String):void
        {
            _listClass = klass;
        }

        public function get usernameClass():String
        {
            return _usernameClass;
        }

        public function set usernameClass(klass:String):void
        {
            _usernameClass = klass;
        }

        public function get hashtagClass():String
        {
            return _hashtagClass;
        }

        public function set hashtagClass(klass:String):void
        {
            _hashtagClass = klass;
        }

        public function get usernameUrlBase():String
        {
            return _usernameUrlBase;
        }

        public function set usernameUrlBase(base:String):void
        {
            _usernameUrlBase = base;
        }

        public function get listUrlBase():String
        {
            return _listUrlBase;
        }

        public function set listUrlBase(base:String):void
        {
            _listUrlBase = base;
        }

        public function get hashtagUrlBase():String
        {
            return _hashtagUrlBase;
        }

        public function set hashtagUrlBase(base:String):void
        {
            _hashtagUrlBase = base;
        }

        public function get isNoFollow():Boolean
        {
            return _noFollow;
        }

        public function set isNoFollow(nofollow:Boolean):void
        {
            _noFollow = nofollow;
        }

        public function autoLink(text:String):String
        {
            return autoLinkUsernamesAndLists(autoLinkURLs(autoLinkHashtags(text)));
        }

        public function autoLinkUsernamesAndLists(text:String):String
        {
            var pattern:RegExp = new RegExp(Patterns.AUTO_LINK_USERNAMES_OR_LISTS, "gi");
            return text.replace(pattern, function():String{
                var replacement:String = "";
                if (arguments[ Patterns.AUTO_LINK_USERNAMES_OR_LIST_GROUP_LIST ] == null
                ||  arguments[ Patterns.AUTO_LINK_USERNAMES_OR_LIST_GROUP_LIST ] == "") {
                    replacement += arguments[ Patterns.AUTO_LINK_USERNAMES_OR_LIST_GROUP_BEFORE ];
                    replacement += arguments[ Patterns.AUTO_LINK_USERNAMES_OR_LIST_GROUP_AT ];
                    replacement += "<a";
                    replacement += " class=\"" + _urlClass + " " + _usernameClass + "\"";
                    replacement += " href=\"" + _usernameUrlBase + arguments[ Patterns.AUTO_LINK_USERNAMES_OR_LIST_GROUP_USERNAME ] + "\"";
                    if (_noFollow)
                        replacement += NO_FOLLOW_HTML_ATTRIBUTE;
                    replacement += ">" + arguments[ Patterns.AUTO_LINK_USERNAMES_OR_LIST_GROUP_USERNAME ] + "</a>";
                } else {
                    replacement += arguments[ Patterns.AUTO_LINK_USERNAMES_OR_LIST_GROUP_USERNAME ];
                    replacement += arguments[ Patterns.AUTO_LINK_USERNAMES_OR_LIST_GROUP_AT ];
                    replacement += "<a";
                    replacement += " class=\"" + _urlClass + " " + _listClass + "\"";
                    replacement += " href=\"" + _listUrlBase + arguments[ Patterns.AUTO_LINK_USERNAMES_OR_LIST_GROUP_USERNAME ] + "\"";
                    replacement += arguments[ Patterns.AUTO_LINK_USERNAMES_OR_LIST_GROUP_LIST ] + "\"";
                    if (_noFollow)
                        replacement += NO_FOLLOW_HTML_ATTRIBUTE;
                    replacement += ">" + arguments[ Patterns.AUTO_LINK_USERNAMES_OR_LIST_GROUP_USERNAME ];
                    replacement += arguments[ Patterns.AUTO_LINK_USERNAMES_OR_LIST_GROUP_LIST ] + "</a>";
                }
                return replacement;
            });
        }

        public function autoLinkHashtags(text:String):String
        {
            var replacement:String = "$";
            replacement += Patterns.AUTO_LINK_HASHTAGS_GROUP_BEFORE;
            replacement += "<a";
            replacement += " href=\""  + _hashtagUrlBase + "$" + Patterns.AUTO_LINK_HASHTAGS_GROUP_TAG + "\"";
            replacement += " title=\"#$" + Patterns.AUTO_LINK_HASHTAGS_GROUP_TAG + "\"";
            replacement += " class=\"" + _urlClass + " " + _hashtagClass + "\"";
            if (_noFollow)
                replacement += NO_FOLLOW_HTML_ATTRIBUTE;

            replacement += ">$";
            replacement += Patterns.AUTO_LINK_HASHTAGS_GROUP_HASH;
            replacement += "$";
            replacement += Patterns.AUTO_LINK_HASHTAGS_GROUP_TAG;
            replacement += "</a>";

            return text.replace(new RegExp(Patterns.AUTO_LINK_HASHTAGS, "gi"), replacement);
        }

        public function autoLinkURLs(text:String):String
        {
            var pattern:RegExp = new RegExp(Patterns.VALID_URL, "gi");
            return text.replace(pattern, function():String {
                var replacement:String = "";
                var urlPart:String = arguments[ Patterns.VALID_URL_GROUP_URL ];
                if (urlPart.match(/^https?:\/\//) != null) {
                    replacement += arguments[ Patterns.VALID_URL_GROUP_BEFORE ];
                    replacement += "<a href=\"" + arguments[ Patterns.VALID_URL_GROUP_URL ] + "\"";
                    if (_noFollow)
                        replacement += NO_FOLLOW_HTML_ATTRIBUTE;
                    replacement += ">"
                    replacement += arguments[ Patterns.VALID_URL_GROUP_URL ];
                    replacement += "</a>";
                } else {
                    replacement += arguments[ Patterns.VALID_URL_GROUP_BEFORE ];
                    replacement += "<a href=\"http://";
                    replacement += arguments[ Patterns.VALID_URL_GROUP_URL ] + "\"";
                    if (_noFollow)
                        replacement += NO_FOLLOW_HTML_ATTRIBUTE;
                    replacement += ">"
                    replacement += arguments[ Patterns.VALID_URL_GROUP_URL ];
                    replacement += "</a>";
                }
                return replacement;
            });
        }
    }
}
