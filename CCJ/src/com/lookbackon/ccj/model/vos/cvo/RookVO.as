package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.ChessPiecesConstants;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.ZobristKeysModel;
	import com.lookbackon.ds.BitBoard;
	import com.vizsage.as3mathlib.types.Arr;
	
	import flash.geom.Point;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class RookVO extends ChessVO
	{
		private var blocker:BitBoard;
		/**
		 * @inheritDoc
		 */
		public function RookVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height,rowIndex,colIndex,flag);
		}
		/**
		 * @inheritDoc
		 */
		override public function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			//    *
			// ***s*****
			//    *
			//Notice:serveral admental(车越子移动/吃子问题)
			//about occupies.
			for(var r:int=0;r<this.row;r++)
			{
				this.occupies.setBitt(r,colIndex,true);
			}
			for(var c:int=0;c<this.column;c++)
			{
				this.occupies.setBitt(rowIndex,c,true);
			}
			//about legal moves.
//			LOG.info("redPieces:{0}",ChessPositionModelLocator.getInstance().redPieces.dump());
//			LOG.info("bluePieces:{0}",ChessPositionModelLocator.getInstance().bluePieces.dump());
			if(flag==CcjConstants.FLAG_RED)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().redPieces));
			}
			if(flag==CcjConstants.FLAG_BLUE)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().bluePieces));
			}
			//blocker
			if(flag==CcjConstants.FLAG_RED)
			{
				blocker = this.occupies.xor(this.moves);
			}else
			{
				blocker = this.occupies.xor(this.moves);
			}
//			trace("blocker.reverse():",blocker.reverse().dump());
			trace("blocker.isEmpty:",blocker.isEmpty);
			if(!blocker.isEmpty)
			{
				trace("blocker:",blocker.dump());
				//
				var east:BitBoard = this.getEast(rowIndex,colIndex);
				var north:BitBoard = this.getNorth(rowIndex,colIndex);
				var west:BitBoard = this.getWest(rowIndex,colIndex);
				var south:BitBoard = this.getSouth(rowIndex,colIndex);
				trace("east:",east.dump());
				trace("north:",north.dump());
				trace("west:",west.dump());
				trace("south:",south.dump());
				this.moves = east.or(north.or(west.or(south)));
				trace("moves:",this.moves.dump());
			}
			//about attacked captures.
			if(flag==CcjConstants.FLAG_RED)
			{
				this.captures = this.moves.and(ChessPiecesModel.getInstance().bluePieces);
			}
			if(flag==CcjConstants.FLAG_BLUE)
			{
				this.captures = this.moves.and(ChessPiecesModel.getInstance().redPieces);
			}
			trace("captures:",this.captures.dump());
		}	
		//----------------------------------
		//  X-ray attacks
		//----------------------------------
		//west
		override protected function getWest(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var w:int=colIndex-1;w>=0;w--)
			{
				if(ChessPiecesModel.getInstance().allPieces.getBitt(rowIndex,w)) break;
				bb.setBitt(rowIndex,w,true);
			}
			return bb;
		}
		//north
		override protected function getNorth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var n:int=rowIndex-1;n>=0;n--)
			{
				if(ChessPiecesModel.getInstance().allPieces.getBitt(n,colIndex)) break;
				bb.setBitt(n,colIndex,true);
			}
			return bb;
		}
		//east
		override protected function getEast(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var e:int=colIndex+1;e<this.column;e++)
			{
				if(ChessPiecesModel.getInstance().allPieces.getBitt(rowIndex,e)) break;
				bb.setBitt(rowIndex,e,true);
			}
			return bb;
		}
		//south
		override protected function getSouth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var s:int=rowIndex+1;s<this.row;s++)
			{
				if(ChessPiecesModel.getInstance().allPieces.getBitt(s,colIndex)) break;
				bb.setBitt(s,colIndex,true);
			}
			return bb;
		}
		
	}
}