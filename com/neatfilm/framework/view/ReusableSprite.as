//------------------------------------------------------------------------------
//  Copyright (c) 2011, George, neatfilm.com.   
//  All rights reserved. 
// 
//  Redistribution and use in source and binary forms, with or without  
//  modification, are permitted provided that the following conditions are 
//  met: 
//  * Redistributions of source code must retain the above copyright notice,  
//    this list of conditions and the following disclaimer. 
//  * Redistributions in binary form must reproduce the above copyright 
//    notice, this list of conditions and the following disclaimer in the  
//    documentation and/or other materials provided with the distribution. 
//  * Neither the name of Adobe Systems Incorporated nor the names of its  
//    contributors may be used to endorse or promote products derived from  
//    this software without specific prior written permission. 
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS 
//  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
//  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
//  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR  
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
//  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
//------------------------------------------------------------------------------
package com.neatfilm.framework.view
{
	import flash.display.Sprite;

	public class ReusableSprite extends Sprite implements IReusable, IObjectEventManager
	{
		private var _pool:ReusablePool;
		private var _inUse:Boolean;

		private var eventManager:ObjectEventManager;

		public function ReusableSprite()
		{
			eventManager = new ObjectEventManager();
			eventManager.owner = this;
		}

		public function get inUse():Boolean
		{
			return _inUse;
		}

		public function set inUse(value:Boolean):void
		{
			_inUse = value;
		}

		public function get pool():ReusablePool
		{
			return _pool;
		}

		public function set pool(value:ReusablePool):void
		{
			_pool = value;
		}

		public function release():void
		{
			_pool.releaseObject(this);
		}

		public function cloneNewObject():IReusable
		{
			var newObject:ReusableSprite = new ReusableSprite();
			return newObject;
		}

		public function registerEvent(type:String, listener:Function):void
		{
			eventManager.registerEvent(type, listener);
		}

		public function unregisterEvent(type:String):void
		{
			eventManager.unregisterEvent(type);
		}

		public function reset():void
		{
			if (parent)
				parent.removeChild(this);
			eventManager.reset();
		}

		public function destroy():void
		{
			eventManager.destroy();
			reset();
			_pool = null;
		}
	}
}
