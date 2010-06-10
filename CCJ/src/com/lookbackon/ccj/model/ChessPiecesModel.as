package com.lookbackon.ccj.model
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.cvo.BishopVO;
	import com.lookbackon.ccj.model.vos.cvo.CannonVO;
	import com.lookbackon.ccj.model.vos.cvo.KnightVO;
	import com.lookbackon.ccj.model.vos.cvo.MarshalVO;
	import com.lookbackon.ccj.model.vos.cvo.OfficalVO;
	import com.lookbackon.ccj.model.vos.cvo.PawnVO;
	import com.lookbackon.ccj.model.vos.cvo.RookVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	
	import de.polygonal.ds.Array2;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	
	/**
	 * A singleton model hold all Chess Pieces's information.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessPiecesModel
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of ChessPositionModelLocator;
		private static var instance:ChessPiecesModel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessPiecesModel);
		//generation.
		//obtain reds/blues chess pieces entity.
		private var _reds:ArrayCollection   = new ArrayCollection();
		private var _blues:ArrayCollection  = new ArrayCollection();
		//
		private var _bluePieces:BitBoard	= new BitBoard(9,10);
		private var _redPieces:BitBoard		= new BitBoard(9,10);
		//special.
		//red
		private var _redRook:BitBoard		= new BitBoard(9,10);
		private var _redKnight:BitBoard		= new BitBoard(9,10);
		private var _redBishop:BitBoard		= new BitBoard(9,10);
		private var _redOffical:BitBoard	= new BitBoard(9,10);
		private var _redMarshal:BitBoard	= new BitBoard(9,10);
		private var _redCannon:BitBoard		= new BitBoard(9,10);
		private var _redPawn:BitBoard		= new BitBoard(9,10);
		//blue
		private var _blueRook:BitBoard		= new BitBoard(9,10);
		private var _blueKnight:BitBoard	= new BitBoard(9,10);
		private var _blueBishop:BitBoard	= new BitBoard(9,10);
		private var _blueOffical:BitBoard	= new BitBoard(9,10);
		private var _blueMarshal:BitBoard	= new BitBoard(9,10);
		private var _blueCannon:BitBoard	= new BitBoard(9,10);
		private var _bluePawn:BitBoard		= new BitBoard(9,10);
		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ChessPiecesModel(access:Private)
		{
			if (access != null) {
				if (instance == null) {
					instance=this;
				}
			} else {
				throw new CcjErrors(CcjErrors.INITIALIZE_SINGLETON_CLASS);
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  blues
		//----------------------------------
		public function get blues():ArrayCollection
		{
			return _blues;
		}
		public function set blues(value:ArrayCollection):void
		{
			_blues = value;
		}
		//----------------------------------
		//  reds
		//----------------------------------
		public function get reds():ArrayCollection
		{
			return _reds;
		}
		public function set reds(value:ArrayCollection):void
		{
			_reds = value;
		}
		//----------------------------------
		//  allPieces
		//----------------------------------
		/**
		 * 
		 * @return our bitboard:(allPieces)
		 * ---------
		 * rkbomobkr
		 * .........
		 * .c.....c.
		 * p.p.p.p.p
		 * .........
		 * ......... 
		 * P.P.P.P.P
		 * .C.....C.
		 * .........
		 * RKBOMOBKR
		 * ---------
		 * 
		 */		
		public function get allPieces():BitBoard
		{
			return redPieces.or(bluePieces);
		}
		//----------------------------------
		//  bluePieces
		//----------------------------------
		/**
		 * 
		 * @return a BitBoard as follows:
		 * ---------
		 * 000000000
		 * 000000000
		 * 000000000
		 * 000000000
		 * 101010101
		 * 010000010
		 * 000000000
		 * 111111111
		 * ---------
		 * 
		 */		
		public function get bluePieces():BitBoard
		{
			return _bluePieces;
		}
		/**
		 * 
		 * @param value a BitBoard representation of bluePieces.
		 * 
		 */		
		public function set bluePieces(value:BitBoard):void
		{
			_bluePieces = value;
			LOG.info("bluePieces:{0}",value.dump());
		}
		//----------------------------------
		//  redPieces
		//----------------------------------
		/**
		 * 
		 * @return a BitBoard as follows:
		 * ---------
		 * 111111111
		 * 000000000
		 * 010000010
		 * 000000000
		 * 101010101
		 * 000000000
		 * 000000000
		 * 000000000
		 * 000000000
		 * ---------
		 * 
		 */		
		public function get redPieces():BitBoard
		{
			return 	_redPieces;
		}
		/**
		 * 
		 * @param value a BitBoard representation of redPieces.
		 * 
		 */		
		public function set redPieces(value:BitBoard):void
		{
			_redPieces = value;
			LOG.info("redPieces:{0}",value.dump());
		}
		//----------------------------------
		//  redRook
		//----------------------------------
		public function get redRook():BitBoard
		{
			return _redRook;
		}
		public function set redRook(value:BitBoard):void
		{
			_redRook = value;
			LOG.info("redRook:{0}",value.dump());
		}
		//----------------------------------
		//  redKnight
		//----------------------------------
		public function get redKnight():BitBoard
		{
			return _redKnight;
		}
		public function set redKnight(value:BitBoard):void
		{
			_redKnight = value;
			LOG.info("redKnight:{0}",value.dump());
		}
		//----------------------------------
		//  redBishop
		//----------------------------------
		public function get redBishop():BitBoard
		{
			return _redBishop;
		}
		public function set redBishop(value:BitBoard):void
		{
			_redBishop = value;
			LOG.info("redBishop:{0}",value.dump());
		}
		//----------------------------------
		//  redOffical
		//----------------------------------
		public function get redOffical():BitBoard
		{
			return _redOffical;
		}
		public function set redOffical(value:BitBoard):void
		{
			_redOffical = value;
			LOG.info("redOffical:{0}",value.dump());
		}
		//----------------------------------
		//  redMarshal
		//----------------------------------
		public function get redMarshal():BitBoard
		{
			return _redMarshal;
		}
		public function set redMarshal(value:BitBoard):void
		{
			_redMarshal = value;
			LOG.info("redMarshal:{0}",value.dump());
		}
		//----------------------------------
		//  redCannon
		//----------------------------------
		public function get redCannon():BitBoard
		{
			return _redCannon;
		}
		public function set redCannon(value:BitBoard):void
		{
			_redCannon = value;
			LOG.info("redCannon:{0}",value.dump());
		}
		//----------------------------------
		//  redPawn
		//----------------------------------
		public function get redPawn():BitBoard
		{
			return _redPawn;
		}
		public function set redPawn(value:BitBoard):void
		{
			_redPawn = value;
			LOG.info("redPawn:{0}",value.dump());
		}
		//----------------------------------
		//  blueRook
		//----------------------------------
		public function get blueRook():BitBoard
		{
			return _blueRook;
		}
		public function set blueRook(value:BitBoard):void
		{
			_blueRook = value;
			LOG.info("blueRook:{0}",value.dump());
		}
		//----------------------------------
		//  blueKnight
		//----------------------------------
		public function get blueKnight():BitBoard
		{
			return _blueKnight;
		}
		public function set blueKnight(value:BitBoard):void
		{
			_blueKnight = value;
			LOG.info("blueKnight:{0}",value.dump());
		}
		//----------------------------------
		//  blueBishop
		//----------------------------------
		public function get blueBishop():BitBoard
		{
			return _blueBishop;
		}
		public function set blueBishop(value:BitBoard):void
		{
			_blueBishop = value;
			LOG.info("blueBishop:{0}",value.dump());
		}
		//----------------------------------
		//  blueOffical
		//----------------------------------
		public function get blueOffical():BitBoard
		{
			return _blueOffical;
		}
		public function set blueOffical(value:BitBoard):void
		{
			_blueOffical = value;
			LOG.info("blueOffical:{0}",value.dump());
		}
		//----------------------------------
		//  blueMarshal
		//----------------------------------
		public function get blueMarshal():BitBoard
		{
			return _blueMarshal;
		}
		public function set blueMarshal(value:BitBoard):void
		{
			_blueMarshal = value;
			LOG.info("blueMarshal:{0}",value.dump());
		}
		//----------------------------------
		//  blueCannon
		//----------------------------------
		public function get blueCannon():BitBoard
		{
			return _blueCannon;
		}
		public function set blueCannon(value:BitBoard):void
		{
			_blueCannon = value;
			LOG.info("blueCannon:{0}",value.dump());
		}
		//----------------------------------
		//  bluePawn
		//----------------------------------
		public function get bluePawn():BitBoard
		{
			return _bluePawn;
		}
		public function set bluePawn(value:BitBoard):void
		{
			_bluePawn = value;
			LOG.info("bluePawn:{0}",value.dump());
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------	
		/**
		 *
		 * @return the singleton instance of ChessPositionModel
		 *
		 */
		public static function getInstance():ChessPiecesModel 
		{
			if (instance == null) 
			{
				instance=new ChessPiecesModel(new Private());
			}
			return instance;
		}
		/**
		 * 
		 * @param type the piece's type.
		 * @param flag the piece's flag.
		 * @return the number of specified type piece.
		 * 
		 */		
		public function numberOf(type:String,flag:int):int
		{
			var fResult:ArrayCollection = new ArrayCollection();
			if(flag==CcjConstants.FLAG_RED)
			{
				fResult = reds;
			}else
			{
				fResult = blues;
			}
			fResult.filterFunction = function(item:Object):Boolean
			{
				return (item as ConductVO).target.label == type;
			};
			return fResult.length;
		}
	}
}
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private 
{
}