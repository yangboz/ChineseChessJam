package flexUnitTests.chessVO.tests
{
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.cvo.RookVO;
	import com.lookbackon.ds.BitBoard;
	
	import org.flexunit.Assert;

	public class RookVOTest extends ChessVOTestBase
	{		
		public function RookVOTest()
		{
			super();
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
		override public function getWest():void
		{
			var west:BitBoard = new BitBoard(9,10);
			var rVO:RookVO = new RookVO(9,10,rowIndexTest,colIndexTest);
//			Assert.assertEquals(rVO.getWest(0,0),west);//notice here forever fail.cuz strick Equals reference,not bitboard's content. 
			Assert.assertTrue(west.xor(rVO.getWest(rowIndexTest,colIndexTest)).isEmpty);
		}
		[Test(descrption="RooVO x-ray north attack test")]
		override public function getNorth():void
		{
			var north:BitBoard = new BitBoard(9,10);
			var rVO:RookVO = new RookVO(9,10,rowIndexTest,colIndexTest);
			//			Assert.assertEquals(rVO.getWest(0,0),west);//notice here forever fail.cuz strick Equals reference,not bitboard's content. 
			Assert.assertTrue(north.xor(rVO.getNorth(rowIndexTest,colIndexTest)).isEmpty);
		}
		[Test(descrption="RooVO x-ray east attack test")]
		override public function getEast():void
		{
			var east:BitBoard = new BitBoard(9,10);
			east.setBitt(rowIndexTest,1,true);
			east.setBitt(rowIndexTest,2,true);
			east.setBitt(rowIndexTest,3,true);
			east.setBitt(rowIndexTest,4,true);
			east.setBitt(rowIndexTest,5,true);
			east.setBitt(rowIndexTest,6,true);
			east.setBitt(rowIndexTest,7,true);
			east.setBitt(rowIndexTest,8,true);
			var rVO:RookVO = new RookVO(9,10,rowIndexTest,colIndexTest);
			//			Assert.assertEquals(rVO.getWest(0,0),west);//notice here forever fail.cuz strick Equals reference,not bitboard's content. 
			Assert.assertTrue(east.xor(rVO.getEast(rowIndexTest,colIndexTest)).isEmpty);
		}
		[Test(descrption="RooVO x-ray south attack test")]
		override public function getSouth():void
		{
			var south:BitBoard = new BitBoard(9,10);
//			south.setBitt(1,0,true);
			south.setBitt(2,0,true);
			var rVO:RookVO = new RookVO(9,10,rowIndexTest,colIndexTest);
			//			Assert.assertEquals(rVO.getWest(0,0),west);//notice here forever fail.cuz strick Equals reference,not bitboard's content. 
			var getSouth:BitBoard = rVO.getSouth(rowIndexTest,colIndexTest);
			Assert.assertTrue(south.xor(getSouth).isEmpty);
		}
		
	}
}