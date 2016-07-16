package org.puremvc.as3.interfaces
{

	public interface IController
	{

		function registerCommand( notificationName : String, commandClassRef : Class ) : void;

		function executeCommand( notification : INotification ) : void;

		function removeCommand( notificationName : String ):void;

		function hasCommand( notificationName:String ) : Boolean;
	}
}