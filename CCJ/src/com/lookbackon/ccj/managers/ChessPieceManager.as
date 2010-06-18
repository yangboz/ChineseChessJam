package com.lookbackon.ccj.managers
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.ZobristKeysModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.ZobristKeyVO;
	import com.lookbackon.ccj.model.vos.cvo.ChessVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.view.components.ChessGasket;
	import com.lookbackon.ccj.view.components.ChessPiece;
	
	import de.polygonal.math.PM_PRNG;
	
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.core.IUIComponent;
	import mx.core.IVisualElement;
	import mx.events.DragEvent;
	import mx.logging.ILogger;
	import mx.managers.DragManager;

	/**
	 * The chess piece manager manage chess piece move's validation/makeMove/unMakeMove.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessPieceManager
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var pmPRNG:PM_PRNG = new PM_PRNG();
		//
		private static var _pieces:ArrayCollection = new ArrayCollection();
		private static var _gaskets:Vector.<ChessGasket> = new Vector.<ChessGasket>();
		private static var _redPieces:ArrayCollection = new ArrayCollection();
		private static var _bluePieces:ArrayCollection = new ArrayCollection();
		private static var _conductsHistorys:Array = [];
		//But the real trick is if we do the XOR operation again we get the initial number back.
		//a ^ b = c
		//c ^ b = a
		private static var _crossOverValue:int;//and we using _crossOverValue for store the value "b";
		private static var _zKey:ZobristKeyVO;//current chess piece's zobrist key value object.
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessPieceManager);
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  gaskets
		//----------------------------------
		public static function get gaskets():Vector.<ChessGasket>
		{
			return _gaskets;
		}
		
		public static function set gaskets(value:Vector.<ChessGasket>):void
		{
			_gaskets = value;
		}
		//----------------------------------
		//  pieces
		//----------------------------------
		public static function get pieces():ArrayCollection
		{
			return _pieces;
		}
		public static function set pieces(value:ArrayCollection):void
		{
			_pieces = value;
		}
		//----------------------------------
		//  redPieces
		//----------------------------------
		public static function get redPieces():ArrayCollection
		{
			return _redPieces;
		}
		//----------------------------------
		//  bluePieces
		//----------------------------------
		public static function get bluePieces():ArrayCollection
		{
			return _bluePieces;
		}
		//----------------------------------
		//  conductsHistorys
		//----------------------------------
		public static function get conductsHistorys():Array
		{
			return _conductsHistorys;
		}
		public static function set conductsHistorys(value:Array):void
		{
			_conductsHistorys = value;
		}
		//generation.
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * 
		 * @param conductVO the conduct value object of moving chess piece.
		 * @return current chess piece's move validation result.
		 * 
		 */		
		public static function doMoveValidation(conductVO:ConductVO):Boolean
		{
			var result:Boolean = true;
			//begin:
//			var beginTime:uint = new Date().getMilliseconds();
//			LOG.info("move validate begin at:{0}",beginTime);
			//chess piece change state(view).
//			conductVO.target.agent.getFSM().changeState(conductVO.target.attackState);
			//TODO:
			//chess piece move (logic) check.
			result = Boolean(conductVO.target.chessVO.moves.getBitt(conductVO.newPosition.y,conductVO.newPosition.x));
//			LOG.info("doMoveValidation result:{0}",result);
			//end
//			var endTime:uint = new Date().getMilliseconds();
//			LOG.info("move validate end at:{0}||duration:{1}",endTime,endTime-beginTime);
			return result;
		}
		/**
		 * 
		 * @param conductVO the conduct value object of moving chess piece.
		 * 
		 */		
		public static function makeMove(conductVO:ConductVO):void
		{
			//TODO:implement functions.
			//manually move chess pieces handler.;
			var cGasketIndex:int = conductVO.newPosition.y*CcjConstants.BOARD_H_LINES+conductVO.newPosition.x;
//			trace(cGasketIndex.toString(),"cGasketIndex");
			var cGasket:ChessGasket = 
				ChessPieceManager.gaskets[cGasketIndex] as ChessGasket;
			//hold gasket skin,then remove previous chess piece.
//			cGasket.dispatchEvent(new DragEvent(DragEvent.DRAG_ENTER,false,true,conductVO.target));
//			cGasket.dispatchEvent(new DragEvent(DragEvent.DRAG_DROP,false,true,conductVO.target));	
			if(cGasket.numElements>1)
			{
				//TODO:chess piece eat off.
				mx.controls.Alert.show(cGasket.position.toString(),"Eat Off !!!");
				//
				cGasket.removeElementAt(1);
			}
			cGasket.addElement(conductVO.target as IVisualElement);
			//adjust the chess piece's position.
			conductVO.target.x = 0;
			conductVO.target.y = 0;
			//update conductsHistorys
			_crossOverValue = pmPRNG.nextInt();
			LOG.debug("_crossOverValue:{0}",_crossOverValue.toString());
			conductsHistorys.push({con:conductVO,cov:_crossOverValue});
			//update allPieces.
			updateAllPiecesPosition(conductVO);
			//update ZobristKeys
			updateZobristKeysModel(conductVO);
			//switch turn flag.
			GameManager.isHumanTurnNow();
		}
		public static function unmakeMove():void
		{
			var conductHistory:* = conductsHistorys.pop();
			var conductVO:ConductVO = conductHistory["con"] as ConductVO;
			var _crossOverValue:int = conductHistory["cov"];
			var oX:int = conductVO.target.position.x;
			var oY:int = conductVO.target.position.y;
			var pX:int = conductVO.newPosition.x;
			var pY:int = conductVO.newPosition.y;
			//TODO:implement functions.
			//ref:http://mediocrechess.blogspot.com/2007/01/guide-zobrist-keys.html.
			_zKey = ZobristKeysModel.getInstance().getZobristKey();
			LOG.debug("before unmakemove:{0}",_zKey.dump());
			//update zobristkey.
			_zKey.position.sett(oX,oY,_crossOverValue^_zKey.position.gett(oX,oY) );
			_zKey.position.sett(pX,pY,_crossOverValue^_zKey.position.gett(pX,pY) );
			//
			LOG.debug("after unmakemove:{0}",_zKey.dump());
			//TODO:unmake updateAllPiecesPosition(based on game turn phase.)
			//
		}
		/**
		 * 
		 * @param conductVO the conduct value object of moving chess piece.
		 * 
		 */
		private static function updateZobristKeysModel(conductVO:ConductVO):void
		{
			//TODO:update ZobristKeys
			var pX:int = conductVO.newPosition.x;
			var pY:int = conductVO.newPosition.y;
			var oX:int = conductVO.target.position.x;
			var oY:int = conductVO.target.position.y;
			//ref:http://mediocrechess.blogspot.com/2007/01/guide-zobrist-keys.html
			_zKey = ZobristKeysModel.getInstance().getZobristKey();
			LOG.debug("before makemove:{0}",_zKey.dump());
			//update zobristkey.
			_zKey.position.sett(oX,oY,_crossOverValue^_zKey.position.gett(oX,oY) );
			_zKey.position.sett(pX,pY,_crossOverValue^_zKey.position.gett(pX,pY) );
			//
			LOG.debug("after makemove:{0}",_zKey.dump());
			//for testing unmakeMove();
//			unmakeMove();
		}
		/**
		 * 
		 * @param conductVO the conduct value object of moving chess piece.
		 * 
		 */
		private static function updateAllPiecesPosition(conductVO:ConductVO):void
		{
			LOG.debug("before move,allPieces:{0}",ChessPiecesModel.getInstance().allPieces.dump());
			if(GameManager.turnFlag==CcjConstants.FLAG_BLUE)
			{
				ChessPiecesModel.getInstance().bluePieces.setBitt(conductVO.target.position.y,conductVO.target.position.x,false);
				ChessPiecesModel.getInstance().bluePieces.setBitt(conductVO.newPosition.y,conductVO.newPosition.x,true);
			}else
			{
				ChessPiecesModel.getInstance().redPieces.setBitt(conductVO.target.position.y,conductVO.target.position.x,false);
				ChessPiecesModel.getInstance().redPieces.setBitt(conductVO.newPosition.y,conductVO.newPosition.x,true);
			}
			LOG.info("after move,allPieces:{0}",ChessPiecesModel.getInstance().allPieces.dump());
		}
	}
	
}
