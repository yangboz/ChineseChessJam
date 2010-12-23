package
{
    import flash.events.Event;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import mx.preloaders.DownloadProgressBar;
    import mx.core.Application;

    import mochi.as3.*;

    // must be dynamic!!
    public dynamic class MochiPreloader extends DownloadProgressBar {
        /*
            MochiPreloader extends DownloadProgressBar here for simplicity.
            You can create more sophisticated preloaders using
            mx.preloaders.IPreloaderDisplay.
        */
        private var _clip:MovieClip;
        private var GAME_OPTIONS:Object;

        public function MochiPreloader()
        {
            super();
            _clip = new MovieClip();
            // add a blank MovieClip to the preloader to hold the Ad
            addChild(_clip);
        }

        override public function set preloader( preloader:Sprite ):void
        {
            /*
                For the preloader to finish, you must dispatch Event.COMPLETE.
                You can include other logos and preloading events by chaining
                event handlers together, using timers, then having the last
                handler dispatch Event.COMPLETE.
            */
            MochiAd.showPreGameAd( {clip: _clip, id:"test", res:width + "x" + height, ad_finished: MochiAdComplete} );
        }

        private function MochiAdComplete():void
        {
            /*
                Ad finished, load the Flex application by
                dispatching Event.COMPLETE
            */
            dispatchEvent( new Event( Event.COMPLETE ) );
        }

     }

}
