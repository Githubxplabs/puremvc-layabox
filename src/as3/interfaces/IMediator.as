package org.puremvc.as3.interfaces
{

	public interface IMediator
	{

		function getMediatorName():String;

		function getViewComponent():Object;

		function setViewComponent( viewComponent:Object ):void;

		function listNotificationInterests( ):Array;

		function handleNotification( notification:INotification ):void;

		function onRegister( ):void;

		function onRemove( ):void;
		
	}
}