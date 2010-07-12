package com.lookbackon.AI.evaluation.linear
{
	import com.lookbackon.AI.evaluation.IEvaluation;
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.ChessPiecesConstants;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.PositionVO;
	
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 * LinearEvaluationProxy.as class.
	 * Similar to Shannon’s 1949 paper, the evaluation for this type of evaluation is defined as:</br>
	 * T = T(red) -T(blue)
	 * Where_ _ * 266 _ _ * 300 _ _ * 66_ *133 _ _ *166 _ _ * 600number of Horses number of Cannon number of pawns
	 * T number Guards number of Elephants number of Rooks black+ + += + +
	 * _ _ * 266 _ _ *300 _ _ * 66_ *133 _ _ *166 _ _ * 600
	 * @author Knight.zhou
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jun 10, 2010 2:09:53 PM
	 */
	public class LinearEvaluationProxy extends Proxy implements IEvaluation
	{
		use namespace flash_proxy;
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		private var _item:Array;
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		//sample:trace(arr.sum()); 6arr.clear();
		public function LinearEvaluationProxy()
		{
			//TODO: implement function
			super();
			_item = new Array();
		}
		/**
		 * 
		 * @param conductVO The conductVO which obtained position information.
		 * @param gamePosition The game position which obtained board position information.
		 * @return Red should try to maximize T as large as possible,
		 * while the Blue should try to minimize T as small as possible. 
		 */		
		public function doEvaluation(conductVO:ConductVO,gamePosition:PositionVO):int
		{
			//TODO: implement function
			var T_red:int = 
				ChessPiecesModel.getInstance().numberOf(ChessPiecesConstants.RED_OFFICAL.label,CcjConstants.FLAG_RED)*133
				+
				ChessPiecesModel.getInstance().numberOf(ChessPiecesConstants.RED_BISHOP.label,CcjConstants.FLAG_RED)*166
				+
				ChessPiecesModel.getInstance().numberOf(ChessPiecesConstants.RED_ROOK.label,CcjConstants.FLAG_RED)*600
				+
				ChessPiecesModel.getInstance().numberOf(ChessPiecesConstants.RED_KNIGHT.label,CcjConstants.FLAG_RED)*266
				+
				ChessPiecesModel.getInstance().numberOf(ChessPiecesConstants.RED_CANNON.label,CcjConstants.FLAG_RED)*300
				+
				ChessPiecesModel.getInstance().numberOf(ChessPiecesConstants.RED_PAWN.label,CcjConstants.FLAG_RED)*66
				;
			var T_blue:int = 
				ChessPiecesModel.getInstance().numberOf(ChessPiecesConstants.BLUE_OFFICAL.label,CcjConstants.FLAG_BLUE)*133
				+
				ChessPiecesModel.getInstance().numberOf(ChessPiecesConstants.BLUE_BISHOP.label,CcjConstants.FLAG_BLUE)*166
				+
				ChessPiecesModel.getInstance().numberOf(ChessPiecesConstants.BLUE_ROOK.label,CcjConstants.FLAG_BLUE)*600
				+
				ChessPiecesModel.getInstance().numberOf(ChessPiecesConstants.BLUE_KNIGHT.label,CcjConstants.FLAG_BLUE)*266
				+
				ChessPiecesModel.getInstance().numberOf(ChessPiecesConstants.BLUE_CANNON.label,CcjConstants.FLAG_BLUE)*300
				+
				ChessPiecesModel.getInstance().numberOf(ChessPiecesConstants.BLUE_PAWN.label,CcjConstants.FLAG_BLUE)*66
				;
			return T_blue-T_red;
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override flash_proxy function callProperty(methodName:*, ... args):* 
		{
			var res:*;
			switch (methodName.toString()) 
			{
				case "clear":
					_item = new Array();
					break;
				case "sum":
					var sum:Number = 0;
					for each (var i:* in _item) 
					{
						// ignore non-numeric values
						if (!isNaN(i)) 
						{
							sum += i;
						}
					}
					res = sum;
					break;
				default:
					res = _item[methodName].apply(_item, args);
					break;
			}
			return res;
		}
		
		override flash_proxy function getProperty(name:*):* 
		{
			return _item[name];
		}
		
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			_item[name] = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}