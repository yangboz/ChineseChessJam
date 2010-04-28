package flexUnitTests.chessVO.tests
{
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.cvo.RookVO;
	import com.lookbackon.ds.BitBoard;
	
	import org.flexunit.Assert;

	public class RookVOTest
	{		
		public function RookVOTest()
		{
			//for test only.
			//blue
			ChessPiecesModel.getInstance().bluePieces.setBitt(0,0,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(0,1,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(0,2,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(0,3,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(0,4,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(0,5,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(0,6,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(0,7,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(0,8,true);
			
			ChessPiecesModel.getInstance().bluePieces.setBitt(2,1,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(2,7,true);
			
			ChessPiecesModel.getInstance().bluePieces.setBitt(3,0,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(3,2,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(3,4,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(3,6,true);
			ChessPiecesModel.getInstance().bluePieces.setBitt(3,8,true);
			//red
			ChessPiecesModel.getInstance().redPieces = ChessPiecesModel.getInstance().bluePieces.reverse();
			
		}
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test(descrption="RooVO x-ray west attack test")]
		public function getWest():void
		{
			var west:BitBoard = new BitBoard(9,10);
			var rVO:RookVO = new RookVO(9,10,0,0);
//			Assert.assertEquals(rVO.getWest(0,0),west);//notice here forever fail.cuz strick Equals reference,not bitboard's content. 
			Assert.assertTrue(west.xor(rVO.getWest(0,0)).isEmpty);
		}
		[Test(descrption="RooVO x-ray north attack test")]
		public function getNorth():void
		{
			var north:BitBoard = new BitBoard(9,10);
			var rVO:RookVO = new RookVO(9,10,0,0);
			//			Assert.assertEquals(rVO.getWest(0,0),west);//notice here forever fail.cuz strick Equals reference,not bitboard's content. 
			Assert.assertTrue(north.xor(rVO.getNorth(0,0)).isEmpty);
		}
		[Test(descrption="RooVO x-ray east attack test")]
		public function getEast():void
		{
			var east:BitBoard = new BitBoard(9,10);
			var rVO:RookVO = new RookVO(9,10,0,0);
			//			Assert.assertEquals(rVO.getWest(0,0),west);//notice here forever fail.cuz strick Equals reference,not bitboard's content. 
			Assert.assertTrue(east.xor(rVO.getEast(0,0)).isEmpty);
		}
		[Test(descrption="RooVO x-ray south attack test")]
		public function getSouth():void
		{
			var south:BitBoard = new BitBoard(9,10);
			south.setBitt(1,0,true);
			south.setBitt(2,0,true);
			var rVO:RookVO = new RookVO(9,10,0,0);
			//			Assert.assertEquals(rVO.getWest(0,0),west);//notice here forever fail.cuz strick Equals reference,not bitboard's content. 
			var getSouth:BitBoard = rVO.getSouth(0,0);
			Assert.assertTrue(south.xor(getSouth).isEmpty);
		}
		
	}
}