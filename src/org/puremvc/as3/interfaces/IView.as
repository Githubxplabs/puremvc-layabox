package org.puremvc.as3.interfaces
{

	public interface IView 
	{

		function registerObserver( notificationName:String, observer:IObserver ) : void;

		function removeObserver( notificationName:String, notifyContext:Object ):void;

		function notifyObservers( note:INotification ) : void;

		function registerMediator( mediator:IMediator ) : void;

		function retrieveMediator( mediatorName:String ) : IMediator;

		function removeMediator( mediatorName:String ) : IMediator;

		function hasMediator( mediatorName:String ) : Boolean;
		
	}
	
}