package com.lookbackon.ccj.managers
{
	import flash.events.IEventDispatcher;
	/**
	* Required methods for a class to register with the EventManager
	*/
	public interface IRegisteredDispatcher extends IEventDispatcher
	{
		function getEvents():Array;
	}
}