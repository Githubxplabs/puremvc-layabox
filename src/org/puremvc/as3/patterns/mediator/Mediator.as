package org.puremvc.as3.patterns.mediator
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.INotifier;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	public class Mediator extends Notifier implements IMediator, INotifier
	{

		public static const NAME:String = 'Mediator';
		
		public function Mediator( mediatorName:String=null, viewComponent:Object=null ) {
			this.mediatorName = (mediatorName != null)?mediatorName:NAME; 
			this.viewComponent = viewComponent;	
		}

		public function getMediatorName():String 
		{	
			return mediatorName;
		}

		public function setViewComponent( viewComponent:Object ):void 
		{
			this.viewComponent = viewComponent;
		}
	
		public function getViewComponent():Object
		{	
			return viewComponent;
		}

		public function listNotificationInterests():Array 
		{
			return [ ];
		}

		public function handleNotification( notification:INotification ):void {}
		

		public function onRegister( ):void {}


		public function onRemove( ):void {}

		// the mediator name
		protected var mediatorName:String;

		// The view component
		protected var viewComponent:Object;
	}
}