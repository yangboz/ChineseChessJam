package com.lookbackon.ccj
{
	import com.lookbackon.ccj.utils.Enum;
	
	import de.polygonal.ds.Array2;

	/**
	 * <b>ChessPieces value/label global setting</b></p>
	 * 1.label for labeling chess pieces button;</p>
	 * 2.value for chess pieces' evaluation;</p>
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	final public class ChessPiecesConstants extends Enum
	{
		{initEnum(ChessPiecesConstants);}//static construct.
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//chessPieceType
		//blue(at top)
		public static const BLUE_PAWN:ChessPiecesConstants 		= new ChessPiecesConstants("p",22,30);//pawn-
		public static const BLUE_ROOK:ChessPiecesConstants 		= new ChessPiecesConstants("r",20,600);//castle-
		public static const BLUE_KNIGHT:ChessPiecesConstants	= new ChessPiecesConstants("k",19,270);//knight-
		public static const BLUE_BISHOP:ChessPiecesConstants	= new ChessPiecesConstants("b",18,120);//bishop-
		public static const BLUE_OFFICAL:ChessPiecesConstants 	= new ChessPiecesConstants("o",16,120);//offcial-
		public static const BLUE_MARSHAL:ChessPiecesConstants	= new ChessPiecesConstants("m",17,6000);//marshal-
		public static const BLUE_CANNON:ChessPiecesConstants	= new ChessPiecesConstants("c",21,285);//cannon-
		//red(at bottom)
		public static const RED_PAWN:ChessPiecesConstants 		= new ChessPiecesConstants("P",14,30);//pawn+
		public static const RED_ROOK:ChessPiecesConstants 		= new ChessPiecesConstants("R",12,600);//castle+
		public static const RED_KNIGHT:ChessPiecesConstants		= new ChessPiecesConstants("K",11,270);//knight+
		public static const RED_BISHOP:ChessPiecesConstants		= new ChessPiecesConstants("B",10,120);//bishop+
		public static const RED_OFFICAL:ChessPiecesConstants 	= new ChessPiecesConstants("O",8,120);//offcial+
		public static const RED_MARSHAL:ChessPiecesConstants	= new ChessPiecesConstants("M",9,6000);//marshal+
		public static const RED_CANNON:ChessPiecesConstants		= new ChessPiecesConstants("C",13,285);//cannon+
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		//
		public var label:String;//for labeling on chess pieces.
		public var value:int;//B. 8~14依次表示红方的帅、仕、相、马、车、炮和兵；
							 //C. 16~22依次表示蓝方的将、士、象、马、车、炮和卒。
		public var strength:int;//Piece: King Assistant Elephant Rook Horse Cannon Pawn
								 //Value: 6000 120 		120 	 600  270    285    30
		public var important:Array2;//precise value.
		//Worst: -4, much worse: -3, worse: -2, slightly worse: -1, even: 0, 
		//slightly better: 1, better:2, much better: 3, best: 4
		public var convertedImportant:Array2;//fuzzy value.
		//
		public function ChessPiecesConstants(label:String,value:int,strength:int=-1,important:Array2=null,convertedImportant:Array2=null)
		{
			this.label = label;
			this.value = value;
			this.strength = strength;
			this.important = new Array2(CcjConstants.BOARD_H_LINES,CcjConstants.BOARD_V_LINES);
			this.convertedImportant = new Array2(CcjConstants.BOARD_H_LINES,CcjConstants.BOARD_V_LINES);
			//TODO:manually set chess pieces' important,reference@2004ccc.pdf.
			switch(label.toLowerCase())
			{
				case "r":
					//important
					this.important.setXs(0,[14,14,12,18,16,18,12,14,14]);
					this.important.setXs(1,[16,20,18,24,26,24,18,20,16]);
					this.important.setXs(2,[12,12,12,18,18,18,12,12,12]);
					this.important.setXs(3,[12,18,16,22,22,22,16,18,12]);
					this.important.setXs(4,[12,14,12,18,18,18,12,14,12]);
					this.important.setXs(5,[12,16,14,20,20,20,14,16,12]);
					this.important.setXs(6,[6,10,8,14,14,14,8,10,6]);
					this.important.setXs(7,[4,8,6,14,12,14,6,8,4]);
					this.important.setXs(8,[8,4,8,16,8,16,8,4,8]);
					this.important.setXs(9,[-2,10,6,14,12,14,6,10,-2]);
					//convertedImportant
					this.convertedImportant.setXs(0,[3,3,2,3,3,3,2,3,3]);
					this.convertedImportant.setXs(1,[3,4,3,4,4,4,3,4,3]);
					this.convertedImportant.setXs(2,[2,2,2,3,3,3,2,2,2]);
					this.convertedImportant.setXs(3,[2,3,3,4,4,4,3,3,2]);
					this.convertedImportant.setXs(4,[2,3,2,3,3,3,2,3,2]);
					this.convertedImportant.setXs(5,[2,3,3,4,4,4,3,3,2]);
					this.convertedImportant.setXs(6,[2,2,2,3,3,3,2,2,2]);
					this.convertedImportant.setXs(7,[1,2,2,3,2,3,2,2,1]);
					this.convertedImportant.setXs(8,[2,1,2,3,2,3,2,1,2]);
					this.convertedImportant.setXs(9,[0,2,2,3,2,3,2,2,0]);
				case "k":
					//important
					this.important.setXs(0,[4,8,16,12,4,12,16,8,4]);
					this.important.setXs(1,[4,10,28,16,8,16,28,10,4]);
					this.important.setXs(2,[12,14,16,20,18,20,16,14,12]);
					this.important.setXs(3,[8,24,18,24,20,24,18,24,8]);
					this.important.setXs(4,[6,16,14,18,16,18,14,16,6]);
					this.important.setXs(5,[4,12,16,14,12,14,16,12,4]);
					this.important.setXs(6,[2,6,8,6,10,6,8,6,2]);
					this.important.setXs(7,[4,2,8,8,4,8,8,2,4]);
					this.important.setXs(8,[0,2,4,4,-2,4,4,2,0]);
					this.important.setXs(9,[0,-4,0,0,0,0,0,-4,0]);
					//convertedImportant
					this.important.setXs(0,[1,2,3,2,1,2,3,2,1]);
					this.important.setXs(1,[1,2,4,3,2,3,4,2,1]);
					this.important.setXs(2,[2,3,3,4,3,4,3,3,2]);
					this.important.setXs(3,[2,4,3,4,4,4,3,4,2]);
					this.important.setXs(4,[2,3,3,3,3,3,3,3,2]);
					this.important.setXs(5,[1,2,3,3,2,3,3,2,1]);
					this.important.setXs(6,[1,2,2,2,2,2,2,2,1]);
					this.important.setXs(7,[1,1,2,2,1,2,2,1,1]);
					this.important.setXs(8,[1,1,1,1,0,1,1,1,1]);
					this.important.setXs(9,[1,0,1,1,1,1,1,0,1]);
				case "c":
					//important
					this.important.setXs(0,[6,4,0,-10,-12,-10,0,4,6]);
					this.important.setXs(1,[2,2,0,-4,-14,-4,0,2,2]);
					this.important.setXs(2,[2,2,0,-10,-8,-10,0,2,2]);
					this.important.setXs(3,[0,0,-2,4,10,4,-2,0,0]);
					this.important.setXs(4,[0,0,0,2,8,2,0,0,0]);
					this.important.setXs(5,[-2,0,4,2,6,2,4,0,-2]);
					this.important.setXs(6,[0,0,0,2,4,2,0,0,0]);
					this.important.setXs(7,[4,0,8,6,10,6,8,0,4]);
					this.important.setXs(8,[0,2,4,6,6,6,4,2,0]);
					this.important.setXs(9,[0,0,2,6,6,6,2,0,0]);
					//convertedImportant
					this.important.setXs(0,[4,3,2,1,1,1,2,3,4]);
					this.important.setXs(1,[3,3,2,2,1,2,2,3,3]);
					this.important.setXs(2,[3,3,2,1,1,1,2,3,3]);
					this.important.setXs(3,[2,2,2,3,4,3,2,2,2]);
					this.important.setXs(4,[2,2,2,3,4,3,2,2,2]);
					this.important.setXs(5,[2,2,3,3,4,3,3,2,2]);
					this.important.setXs(6,[2,2,2,3,3,3,2,2,2]);
					this.important.setXs(7,[3,2,4,4,4,4,4,2,3]);
					this.important.setXs(8,[2,3,3,4,4,4,3,3,2]);
					this.important.setXs(9,[2,2,3,4,4,4,3,2,2]);
				case "p":
					//important
					this.important.setXs(0,[0,3,6,9,12,9,6,3,0]);
					this.important.setXs(1,[18,36,56,80,120,80,56,36,18]);
					this.important.setXs(2,[14,26,42,60,80,60,42,26,14]);
					this.important.setXs(3,[10,20,30,34,40,34,30,20,10]);
					this.important.setXs(4,[6,12,18,18,20,18,18,12,6]);
					this.important.setXs(5,[2,0,8,0,8,0,8,0,2]);
					this.important.setXs(6,[0,0,-2,0,4,0,-2,0,0]);
					this.important.setXs(7,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(8,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(9,[0,0,0,0,0,0,0,0,0]);
					//convertedImportant
					this.important.setXs(0,[0,0,2,2,2,2,2,0,0]);
					this.important.setXs(1,[3,4,4,4,4,4,4,4,3]);
					this.important.setXs(2,[3,4,4,4,4,4,4,4,3]);
					this.important.setXs(3,[2,4,4,4,4,4,4,4,2]);
					this.important.setXs(4,[2,2,3,3,4,3,3,2,2]);
					this.important.setXs(5,[0,0,2,0,2,0,2,0,0]);
					this.important.setXs(6,[0,0,–1,0,0,0,-1,0,0]);
					this.important.setXs(7,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(8,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(9,[0,0,0,0,0,0,0,0,0]);
					break;
				case "b":
					//important
					//convertedImportant
					this.important.setXs(0,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(1,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(2,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(3,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(4,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(5,[0,0,-1,0,0,0,-1,0,0]);
					this.important.setXs(6,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(7,[-2,0,0,0,3,0,0,0,-2]);
					this.important.setXs(8,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(9,[0,0,1,0,0,0,1,0,0]);
					break;
				case "o":
					//important
					//convertedImportant
					this.important.setXs(0,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(1,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(2,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(3,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(4,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(5,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(6,[0,0,0,0,0,0,0,0,0]);
					this.important.setXs(7,[0,0,0,-1,0,-1,0,0,0]);
					this.important.setXs(8,[0,0,0,0,3,0,0,0,0]);
					this.important.setXs(9,[0,0,0,1,0,1,0,0,0]);
					break;
				case "m":
					//important
					//convertedImportant
					this.important.setXs(0,[-2,-2,-2,2,2,2,-2,-2,-2]);
					this.important.setXs(1,[-2,-2,-2,2,2,2,-2,-2,-2]);
					this.important.setXs(2,[-2,-2,-2,2,2,2,-2,-2,-2]);
					this.important.setXs(3,[-2,-2,-2,-2,-2,-2,-2,-2,-2]);
					this.important.setXs(4,[-2,-2,-2,-2,-2,-2,-2,-2,-2]);
					this.important.setXs(5,[-2,-2,-2,-2,-2,-2,-2,-2,-2]);
					this.important.setXs(6,[-2,-2,-2,-2,-2,-2,-2,-2,-2]);
					this.important.setXs(7,[-2,-2,-2,-2,-2,-2,-2,-2,-2]);
					this.important.setXs(8,[-2,-2,-2,-2,-2,-2,-2,-2,-2]);
					this.important.setXs(9,[-2,-2,-2,-2,-2,-2,-2,-2,-2]);
					break;
			}
		}
	}
}
