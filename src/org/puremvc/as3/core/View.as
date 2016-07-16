package org.puremvc.as3.core
{

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.IObserver;
	import org.puremvc.as3.interfaces.IView;
	import org.puremvc.as3.patterns.observer.Observer;

	public class View implements IView
	{
		
		public function View( )
		{
			if (instance != null) throw Error(SINGLETON_MSG);
			instance = this;
			mediatorMap = new Object();
			observerMap = new Object();	
			initializeView();	
		}
		
		protected function initializeView(  ) : void 
		{
		}
	
		public static function getInstance() : IView 
		{
			if ( instance == null ) instance = new View( );
			return instance;
		}
				
		public function registerObserver ( notificationName:String, observer:IObserver ) : void
		{
			var observers:Array = observerMap[ notificationName ];
			if( observers ) {
				observers.push( observer );
			} else {
				observerMap[ notificationName ] = [ observer ];	
			}
		}

		public function notifyObservers( notification:INotification ) : void
		{
			if( observerMap[ notification.getName() ] != null ) {
				
				// Get a reference to the observers list for this notification name
				var observers_ref:Array = observerMap[ notification.getName() ] as Array;

				// Copy observers from reference array to working array, 
				// since the reference array may change during the notification loop
   				var observers:Array = new Array(); 
   				var observer:IObserver;
				for (var i:Number = 0; i < observers_ref.length; i++) { 
					observer = observers_ref[ i ] as IObserver;
					observers.push( observer );
				}
				
				// Notify Observers from the working array				
				for (i = 0; i < observers.length; i++) {
					observer = observers[ i ] as IObserver;
					observer.notifyObserver( notification );
				}
			}
		}
		
		public function removeObserver( notificationName:String, notifyContext:Object ):void
		{
			// the observer list for the notification under inspection
			var observers:Array = observerMap[ notificationName ] as Array;

			// find the observer for the notifyContext
			for ( var i:int=0; i<observers.length; i++ ) 
			{
				if ( Observer(observers[i]).compareNotifyContext( notifyContext ) == true ) {
					// there can only be one Observer for a given notifyContext 
					// in any given Observer list, so remove it and break
					observers.splice(i,1);
					break;
				}
			}

			// Also, when a Notification's Observer list length falls to 
			// zero, delete the notification key from the observer map
			if ( observers.length == 0 ) {
				delete observerMap[ notificationName ];		
			}
		} 

		public function registerMediator( mediator:IMediator ) : void
		{
			// do not allow re-registration (you must to removeMediator fist)
			if ( mediatorMap[ mediator.getMediatorName() ] != null ) return;
			
			// Register the Mediator for retrieval by name
			mediatorMap[ mediator.getMediatorName() ] = mediator;
			
			// Get Notification interests, if any.
			var interests:Array = mediator.listNotificationInterests();

			// Register Mediator as an observer for each of its notification interests
			if ( interests.length > 0 ) 
			{
				// Create Observer referencing this mediator's handlNotification method
				var observer:Observer = new Observer( mediator.handleNotification, mediator );

				// Register Mediator as Observer for its list of Notification interests
				for ( var i:Number=0;  i<interests.length; i++ ) {
					registerObserver( interests[i],  observer );
				}			
			}
			
			// alert the mediator that it has been registered
			mediator.onRegister();
			
		}

		public function retrieveMediator( mediatorName:String ) : IMediator
		{
			return mediatorMap[ mediatorName ];
		}

		public function removeMediator( mediatorName:String ) : IMediator
		{
			// Retrieve the named mediator
			var mediator:IMediator = mediatorMap[ mediatorName ] as IMediator;
			
			if ( mediator ) 
			{
				// for every notification this mediator is interested in...
				var interests:Array = mediator.listNotificationInterests();
				for ( var i:Number=0; i<interests.length; i++ ) 
				{
					// remove the observer linking the mediator 
					// to the notification interest
					removeObserver( interests[i], mediator );
				}	
				
				// remove the mediator from the map		
				delete mediatorMap[ mediatorName ];
	
				// alert the mediator that it has been removed
				mediator.onRemove();
			}
			
			return mediator;
		}
		
		public function hasMediator( mediatorName:String ) : Boolean
		{
			return mediatorMap[ mediatorName ] != null;
		}

		// Mapping of Mediator names to Mediator instances
		protected var mediatorMap : Object;

		// Mapping of Notification names to Observer lists
		protected var observerMap	: Object;
		
		// Singleton instance
		protected static var instance	: IView;

		// Message Constants
		protected const SINGLETON_MSG	: String = "View Singleton already constructed!";
	}
}