package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.ChessPiecesConstants;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.ZobristKeysModel;
	import com.lookbackon.ds.BitBoard;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class RookVO extends ChessVO
	{
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
			//about attacked captures.
			if(flag==CcjConstants.FLAG_RED)
			{
				this.captures = this.moves.and(ChessPiecesModel.getInstance().bluePieces);
			}
			if(flag==CcjConstants.FLAG_BLUE)
			{
				this.captures = this.moves.and(ChessPiecesModel.getInstance().redPieces);
			}
			//blocker
			var blocker:BitBoard = this.occupies.xor(this.moves);
			trace("blocker:",blocker.dump());
			trace("blocker.reverse():",blocker.reverse().dump());
			trace("blocker.isEmtpty:",blocker.isEmtpty);
			//rayAttack
			var rayAttack:BitBoard = new BitBoard(this.column,this.row);
			//north
			var nAttack:BitBoard = new BitBoard(this.column,this.row);
			for(var n:int=rowIndex-1;n>=0;n--)
			{
				nAttack.setBitt(n,colIndex,true);
			}
			trace("nAttack:",nAttack.dump());
			//east
			var eAttack:BitBoard = new BitBoard(this.column,this.row);
			for(var e:int=colIndex+1;e<=this.column;e++)
			{
				eAttack.setBitt(rowIndex,e,true);
			}
			trace("eAttack:",eAttack.dump());
			//south
			var sAttack:BitBoard = new BitBoard(this.column,this.row);
			for(var s:int=rowIndex+1;s<this.row;s++)
			{
				sAttack.setBitt(s,colIndex,true);
			}
			trace("sAttack:",sAttack.dump());
			//west
			var wAttack:BitBoard = new BitBoard(this.column,this.row);
			for(var w:int=colIndex-1;w>=0;w--)
			{
				wAttack.setBitt(rowIndex,w,true);
			}
			trace("wAttack:",wAttack.dump());
			//
			rayAttack = nAttack.or(eAttack).or(sAttack).or(wAttack);
			trace("rayAttack:",rayAttack.dump());
			trace("rayAttack|blocker:",rayAttack.xor(blocker).dump());
		}
	}
}