package org.puremvc.as3.patterns.facade
{

	import org.puremvc.as3.core.Controller;
	import org.puremvc.as3.core.Model;
	import org.puremvc.as3.core.View;
	import org.puremvc.as3.interfaces.IController;
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.IModel;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.interfaces.IView;
	import org.puremvc.as3.patterns.observer.Notification;

	public class Facade implements IFacade
	{

		public function Facade( ) {
			if (instance != null) throw Error(SINGLETON_MSG);
			instance = this;
			initializeFacade();	
		}

		protected function initializeFacade(  ):void {
			initializeModel();
			initializeController();
			initializeView();
		}

		public static function getInstance():IFacade {
			if (instance == null) instance = new Facade( );
			return instance;
		}

		protected function initializeController( ):void {
			if ( controller != null ) return;
			controller = Controller.getInstance();
		}

		protected function initializeModel( ):void {
			if ( model != null ) return;
			model = Model.getInstance();
		}
		
		protected function initializeView( ):void {
			if ( view != null ) return;
			view = View.getInstance();
		}

		public function registerCommand( notificationName:String, commandClassRef:Class ):void 
		{
			controller.registerCommand( notificationName, commandClassRef );
		}

		public function removeCommand( notificationName:String ):void 
		{
			controller.removeCommand( notificationName );
		}

		public function hasCommand( notificationName:String ) : Boolean
		{
			return controller.hasCommand(notificationName);
		}

		public function registerProxy ( proxy:IProxy ):void	
		{
			model.registerProxy ( proxy );	
		}

		public function retrieveProxy ( proxyName:String ):IProxy 
		{
			return model.retrieveProxy ( proxyName );	
		}


		public function removeProxy ( proxyName:String ):IProxy 
		{
			var proxy:IProxy;
			if ( model != null ) proxy = model.removeProxy ( proxyName );	
			return proxy
		}

		public function hasProxy( proxyName:String ) : Boolean
		{
			return model.hasProxy( proxyName );
		}

		public function registerMediator( mediator:IMediator ):void 
		{
			if ( view != null ) view.registerMediator( mediator );
		}

		public function retrieveMediator( mediatorName:String ):IMediator 
		{
			return view.retrieveMediator( mediatorName ) as IMediator;
		}

		public function removeMediator( mediatorName:String ) : IMediator 
		{
			var mediator:IMediator;
			if ( view != null ) mediator = view.removeMediator( mediatorName );			
			return mediator;
		}

		public function hasMediator( mediatorName:String ) : Boolean
		{
			return view.hasMediator( mediatorName );
		}

		public function sendNotification( notificationName:String, body:Object=null, type:String=null ):void 
		{
			notifyObservers( new Notification( notificationName, body, type ) );
		}

		public function notifyObservers ( notification:INotification ):void {
			if ( view != null ) view.notifyObservers( notification );
		}

		// Private references to Model, View and Controller
		protected var controller : IController;
		protected var model		 : IModel;
		protected var view		 : IView;
		
		// The Singleton Facade instance.
		protected static var instance : IFacade; 
		
		// Message Constants
		protected const SINGLETON_MSG	: String = "Facade Singleton already constructed!";
	
	}
}