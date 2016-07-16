package org.puremvc.as3.interfaces
{

	public interface IObserver
	{

		function setNotifyMethod( notifyMethod:Function ):void;
		
		function setNotifyContext( notifyContext:Object ):void;

		function notifyObserver( notification:INotification ):void;

		function compareNotifyContext( object:Object ):Boolean;
	}
}