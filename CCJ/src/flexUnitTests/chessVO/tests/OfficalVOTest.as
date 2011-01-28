package flexUnitTests.chessVO.tests
{
	import com.godpaper.model.ChessPiecesModel;
	import com.godpaper.model.vos.ccjVO.OfficalVO;
	import com.lookbackon.ds.BitBoard;
	
	import org.flexunit.Assert;

	public class OfficalVOTest extends ChessVOTestBase
	{
		public function OfficalVOTest()
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
			this.colIndexTest = 3;
			this.rowIndexTest = 0;
		}
		//
		[Test(descrption="OfficalVO occuipes test")]
		override public function occuipes():void
		{
			var occuipesExpect:BitBoard = new BitBoard(9,10);
			occuipesExpect.setBitt(1,4,true);
			var oVO:OfficalVO = new OfficalVO(9,10,rowIndexTest,colIndexTest);
			Assert.assertTrue(occuipesExpect.xor(oVO.occupies).isEmpty);
		}
		
		[Test(descrption="OfficalVO moves test")]
		override public function moves():void
		{
			var movesExpect:BitBoard = new BitBoard(9,10);
			movesExpect.setBitt(1,4,true);
			var oVO:OfficalVO = new OfficalVO(9,10,rowIndexTest,colIndexTest);
			Assert.assertTrue(movesExpect.xor(oVO.moves).isEmpty);
		}
		
		[Test(descrption="OfficalVO captures test")]
		override public function captures():void
		{
			var capturesExpect:BitBoard = new BitBoard(9,10);
			var oVO:OfficalVO = new OfficalVO(9,10,rowIndexTest,colIndexTest);
			Assert.assertTrue(capturesExpect.xor(oVO.captures).isEmpty);
		}
		
		
	}
}