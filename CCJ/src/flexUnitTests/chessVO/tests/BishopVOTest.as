package flexUnitTests.chessVO.tests
{
	import com.lookbackon.ccj.model.vos.cvo.BishopVO;
	import com.lookbackon.ds.BitBoard;
	
	import org.flexunit.Assert;

	public class BishopVOTest extends ChessVOTestBase
	{		
		public function BishopVOTest()
		{
			//TODO: implement function
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
			this.colIndexTest = 6;
			this.rowIndexTest = 0;
		}
		//
		[Test(descrption="BishopVO occuipes test")]
		override public function occuipes():void
		{
			var occuipesExpect:BitBoard = new BitBoard(9,10);
			occuipesExpect.setBitt(2,4,true);
			occuipesExpect.setBitt(2,8,true);
			var oVO:BishopVO = new BishopVO(9,10,rowIndexTest,colIndexTest);
			Assert.assertTrue(occuipesExpect.xor(oVO.occupies).isEmpty);
		}
		
		[Test(descrption="BishopVO moves test")]
		override public function moves():void
		{
			var movesExpect:BitBoard = new BitBoard(9,10);
			movesExpect.setBitt(2,4,true);
			movesExpect.setBitt(2,8,true);
			var oVO:BishopVO = new BishopVO(9,10,rowIndexTest,colIndexTest);
			Assert.assertTrue(movesExpect.xor(oVO.moves).isEmpty);
		}
		
		[Test(descrption="BishopVO captures test")]
		override public function captures():void
		{
			var capturesExpect:BitBoard = new BitBoard(9,10);
			var oVO:BishopVO = new BishopVO(9,10,rowIndexTest,colIndexTest);
			Assert.assertTrue(capturesExpect.xor(oVO.captures).isEmpty);
		}
		
		
	}
}