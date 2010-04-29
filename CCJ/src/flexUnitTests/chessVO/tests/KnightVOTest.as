package flexUnitTests.chessVO.tests
{
	import com.lookbackon.ccj.model.vos.cvo.KnightVO;
	import com.lookbackon.ds.BitBoard;
	
	import org.flexunit.Assert;

	public class KnightVOTest extends ChessVOTestBase
	{		
		public function KnightVOTest()
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
			this.colIndexTest = 7;
			this.rowIndexTest = 0;
		}
		//
		[Test(descrption="KnightVO occuipes test")]
		override public function occuipes():void
		{
			var occuipesExpect:BitBoard = new BitBoard(9,10);
			occuipesExpect.setBitt(2,8,true);
			occuipesExpect.setBitt(2,6,true);
			var kVO:KnightVO = new KnightVO(9,10,rowIndexTest,colIndexTest);
			Assert.assertTrue(occuipesExpect.xor(kVO.occupies).isEmpty);
		}
		
		[Test(descrption="KnightVO moves test")]
		override public function moves():void
		{
			var movesExpect:BitBoard = new BitBoard(9,10);
			movesExpect.setBitt(2,8,true);
			movesExpect.setBitt(2,6,true);
			var oVO:KnightVO = new KnightVO(9,10,rowIndexTest,colIndexTest);
			Assert.assertTrue(movesExpect.xor(oVO.moves).isEmpty);
		}
		
		[Test(descrption="KnightVO captures test")]
		override public function captures():void
		{
			var capturesExpect:BitBoard = new BitBoard(9,10);
			var oVO:KnightVO = new KnightVO(9,10,rowIndexTest,colIndexTest);
			Assert.assertTrue(capturesExpect.xor(oVO.captures).isEmpty);
		}
		
		
	}
}