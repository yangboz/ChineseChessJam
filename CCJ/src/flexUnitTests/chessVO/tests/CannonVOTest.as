package flexUnitTests.chessVO.tests
{
	import com.godpaper.model.ChessPiecesModel;
	import com.godpaper.model.vos.ccjVO.CannonVO;
	import com.godpaper.model.vos.ccjVO.RookVO;
	import com.lookbackon.ds.BitBoard;
	
	import org.flexunit.Assert;
	
	public class CannonVOTest extends ChessVOTestBase
	{		
		public function CannonVOTest()
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
		
		override protected function initialization():void
		{
			super.initialization();
			//
			this.rowIndexTest = 2;
			this.colIndexTest = 1;
		}
		
		[Test(descrption="CannonVO x-ray west attack test")]
		override public function getWest():void
		{
			var west:BitBoard = new BitBoard(9,10);
			west.setBitt(rowIndexTest,0,true);
			var rVO:CannonVO = new CannonVO(9,10,rowIndexTest,colIndexTest);
			//			Assert.assertEquals(rVO.getWest(0,0),west);//notice here forever fail.cuz strick Equals reference,not bitboard's content. 
			var getWest:BitBoard = rVO.getWest(rowIndexTest,colIndexTest);
			Assert.assertTrue(west.xor(getWest).isEmpty);
		}
		[Test(descrption="CannonVO x-ray north attack test")]
		override public function getNorth():void
		{
			var north:BitBoard = new BitBoard(9,10);
			north.setBitt(1,colIndexTest,true);
			var rVO:CannonVO = new CannonVO(9,10,rowIndexTest,colIndexTest);
			//			Assert.assertEquals(rVO.getWest(0,0),west);//notice here forever fail.cuz strick Equals reference,not bitboard's content. 
			var getNorth:BitBoard = rVO.getNorth(rowIndexTest,colIndexTest);
			Assert.assertTrue(north.xor(getNorth).isEmpty);
		}
		[Test(descrption="CannonVO x-ray east attack test")]
		override public function getEast():void
		{
			var east:BitBoard = new BitBoard(9,10);
			east.setBitt(rowIndexTest,2,true);
			east.setBitt(rowIndexTest,3,true);
			east.setBitt(rowIndexTest,4,true);
			east.setBitt(rowIndexTest,5,true);
			east.setBitt(rowIndexTest,6,true);
			var rVO:CannonVO = new CannonVO(9,10,rowIndexTest,colIndexTest);
			//			Assert.assertEquals(rVO.getWest(0,0),west);//notice here forever fail.cuz strick Equals reference,not bitboard's content. 
			var getEast:BitBoard = rVO.getEast(rowIndexTest,colIndexTest);
			Assert.assertTrue(east.xor(getEast).isEmpty);
		}
		[Test(descrption="CannonVO x-ray south attack test")]
		override public function getSouth():void
		{
			var south:BitBoard = new BitBoard(9,10);
			//			south.setBitt(1,0,true);
			south.setBitt(3,colIndexTest,true);
			south.setBitt(4,colIndexTest,true);
			south.setBitt(5,colIndexTest,true);
			south.setBitt(6,colIndexTest,true);
			south.setBitt(9,colIndexTest,true);
			var rVO:CannonVO = new CannonVO(9,10,rowIndexTest,colIndexTest);
			//			Assert.assertEquals(rVO.getWest(0,0),west);//notice here forever fail.cuz strick Equals reference,not bitboard's content. 
			var getSouth:BitBoard = rVO.getSouth(rowIndexTest,colIndexTest);
			Assert.assertTrue(south.xor(getSouth).isEmpty);
		}
		
	}
}