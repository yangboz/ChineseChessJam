package com.lookbackon.ccj.model
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.PositionVO;
	import com.lookbackon.ccj.model.vos.cvo.BishopVO;
	import com.lookbackon.ccj.model.vos.cvo.CannonVO;
	import com.lookbackon.ccj.model.vos.cvo.KnightVO;
	import com.lookbackon.ccj.model.vos.cvo.MarshalVO;
	import com.lookbackon.ccj.model.vos.cvo.OfficalVO;
	import com.lookbackon.ccj.model.vos.cvo.PawnVO;
	import com.lookbackon.ccj.model.vos.cvo.RookVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.view.components.ChessPiece;
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
		private static const LOG:ILogger=LogUtil.getLogger(ChessPiecesModel);
		//generation.
		//obtain reds/blues chess pieces entity.
		private var _reds:Vector.<ChessPiece>=new Vector.<ChessPiece>();
		private var _blues:Vector.<ChessPiece>=new Vector.<ChessPiece>();
		private var _pieces:Vector.<ChessPiece>=new Vector.<ChessPiece>();
		//
		private var _bluePieces:BitBoard=new BitBoard(9, 10);
		private var _redPieces:BitBoard=new BitBoard(9, 10);
		//special.
		//red
		private var _redRook:BitBoard=new BitBoard(9, 10);
		private var _redKnight:BitBoard=new BitBoard(9, 10);
		private var _redBishop:BitBoard=new BitBoard(9, 10);
		private var _redOffical:BitBoard=new BitBoard(9, 10);
		private var _redMarshal:BitBoard=new BitBoard(9, 10);
		private var _redCannon:BitBoard=new BitBoard(9, 10);
		private var _redPawn:BitBoard=new BitBoard(9, 10);
		//blue
		private var _blueRook:BitBoard=new BitBoard(9, 10);
		private var _blueKnight:BitBoard=new BitBoard(9, 10);
		private var _blueBishop:BitBoard=new BitBoard(9, 10);
		private var _blueOffical:BitBoard=new BitBoard(9, 10);
		private var _blueMarshal:BitBoard=new BitBoard(9, 10);
		private var _blueCannon:BitBoard=new BitBoard(9, 10);
		private var _bluePawn:BitBoard=new BitBoard(9, 10);

		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ChessPiecesModel(access:Private)
		{
			if (access != null)
			{
				if (instance == null)
				{
					instance=this;
				}
			}
			else
			{
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
		public function get blues():Vector.<ChessPiece>
		{
			return _blues;
		}

		public function set blues(value:Vector.<ChessPiece>):void
		{
			_blues=value;
		}

		//----------------------------------
		//  reds
		//----------------------------------
		public function get reds():Vector.<ChessPiece>
		{
			return _reds;
		}

		public function set reds(value:Vector.<ChessPiece>):void
		{
			_reds=value;
		}

		//----------------------------------
		//  pieces
		//----------------------------------
		public function get pieces():Vector.<ChessPiece>
		{
			return reds.concat(blues);
		}

		//----------------------------------
		//  gamePosition
		//----------------------------------
		public function get gamePosition():PositionVO
		{
			var _gamePosition:PositionVO=new PositionVO();
			var board:Array2=new Array2(9, 10);
			for (var i:int=0; i < pieces.length; i++)
			{
				var cp:ChessPiece=pieces[i];
				board.sett(cp.position.x, cp.position.y, cp);
			}
			_gamePosition.board=board;
			_gamePosition.color=CcjConstants.FLAG_BLUE;
			return _gamePosition;
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
//			return _bluePieces;
			return BLUE_ROOK.or(BLUE_KNIGHT).or(BLUE_BISHOP).or(BLUE_OFFICAL).or(BLUE_MARSHAL).or(BLUE_CANNON).or(BLUE_PAWN);
		}

		/**
		 * Notice:set only for unit-test.
		 * @param value a BitBoard representation of bluePieces.
		 *
		 */
		public function set bluePieces(value:BitBoard):void
		{
			_bluePieces=value;
			LOG.info("bluePieces:{0}", value.dump());
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
//			return 	_redPieces;
			return RED_ROOK.or(RED_KNIGHT).or(RED_BISHOP).or(RED_OFFICAL).or(RED_MARSHAL).or(RED_CANNON).or(RED_PAWN);
		}

		/**
		 * Notice:set only for unit-test.
		 * @param value a BitBoard representation of redPieces.
		 *
		 */
		public function set redPieces(value:BitBoard):void
		{
			_redPieces=value;
			LOG.info("redPieces:{0}", value.dump());
		}

		//----------------------------------
		//  redRook
		//----------------------------------
		public function get RED_ROOK():BitBoard
		{
			return _redRook;
		}

		public function set RED_ROOK(value:BitBoard):void
		{
			_redRook=value;
			LOG.info("RED_ROOK:{0}", value.dump());
		}

		//----------------------------------
		//  redKnight
		//----------------------------------
		public function get RED_KNIGHT():BitBoard
		{
			return _redKnight;
		}

		public function set RED_KNIGHT(value:BitBoard):void
		{
			_redKnight=value;
			LOG.info("RED_KNIGHT:{0}", value.dump());
		}

		//----------------------------------
		//  redBishop
		//----------------------------------
		public function get RED_BISHOP():BitBoard
		{
			return _redBishop;
		}

		public function set RED_BISHOP(value:BitBoard):void
		{
			_redBishop=value;
			LOG.info("RED_BISHOP:{0}", value.dump());
		}

		//----------------------------------
		//  redOffical
		//----------------------------------
		public function get RED_OFFICAL():BitBoard
		{
			return _redOffical;
		}

		public function set RED_OFFICAL(value:BitBoard):void
		{
			_redOffical=value;
			LOG.info("RED_OFFICAL:{0}", value.dump());
		}

		//----------------------------------
		//  redMarshal
		//----------------------------------
		public function get RED_MARSHAL():BitBoard
		{
			return _redMarshal;
		}

		public function set RED_MARSHAL(value:BitBoard):void
		{
			_redMarshal=value;
			LOG.info("RED_MARSHAL:{0}", value.dump());
		}

		//----------------------------------
		//  redCannon
		//----------------------------------
		public function get RED_CANNON():BitBoard
		{
			return _redCannon;
		}

		public function set RED_CANNON(value:BitBoard):void
		{
			_redCannon=value;
			LOG.info("RED_CANNON:{0}", value.dump());
		}

		//----------------------------------
		//  redPawn
		//----------------------------------
		public function get RED_PAWN():BitBoard
		{
			return _redPawn;
		}

		public function set RED_PAWN(value:BitBoard):void
		{
			_redPawn=value;
			LOG.info("RED_PAWN:{0}", value.dump());
		}

		//----------------------------------
		//  blueRook
		//----------------------------------
		public function get BLUE_ROOK():BitBoard
		{
			return _blueRook;
		}

		public function set BLUE_ROOK(value:BitBoard):void
		{
			_blueRook=value;
			LOG.info("BLUE_ROOK:{0}", value.dump());
		}

		//----------------------------------
		//  blueKnight
		//----------------------------------
		public function get BLUE_KNIGHT():BitBoard
		{
			return _blueKnight;
		}

		public function set BLUE_KNIGHT(value:BitBoard):void
		{
			_blueKnight=value;
			LOG.info("BLUE_KNIGHT:{0}", value.dump());
		}

		//----------------------------------
		//  blueBishop
		//----------------------------------
		public function get BLUE_BISHOP():BitBoard
		{
			return _blueBishop;
		}

		public function set BLUE_BISHOP(value:BitBoard):void
		{
			_blueBishop=value;
			LOG.info("BLUE_BISHOP:{0}", value.dump());
		}

		//----------------------------------
		//  blueOffical
		//----------------------------------
		public function get BLUE_OFFICAL():BitBoard
		{
			return _blueOffical;
		}

		public function set BLUE_OFFICAL(value:BitBoard):void
		{
			_blueOffical=value;
			LOG.info("BLUE_OFFICAL:{0}", value.dump());
		}

		//----------------------------------
		//  blueMarshal
		//----------------------------------
		public function get BLUE_MARSHAL():BitBoard
		{
			return _blueMarshal;
		}

		public function set BLUE_MARSHAL(value:BitBoard):void
		{
			_blueMarshal=value;
			LOG.info("BLUE_MARSHAL:{0}", value.dump());
		}

		//----------------------------------
		//  blueCannon
		//----------------------------------
		public function get BLUE_CANNON():BitBoard
		{
			return _blueCannon;
		}

		public function set BLUE_CANNON(value:BitBoard):void
		{
			_blueCannon=value;
			LOG.info("BLUE_CANNON:{0}", value.dump());
		}

		//----------------------------------
		//  bluePawn
		//----------------------------------
		public function get BLUE_PAWN():BitBoard
		{
			return _bluePawn;
		}

		public function set BLUE_PAWN(value:BitBoard):void
		{
			_bluePawn=value;
			LOG.info("BLUE_PAWN:{0}", value.dump());
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
	}
}

/**
 *Inner class which restricts construtor access to Private
 */
internal class Private
{
}