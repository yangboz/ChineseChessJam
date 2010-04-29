package flexUnitTests.chessVO.tests
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.model.vos.cvo.PawnVO;
	import com.lookbackon.ds.BitBoard;
	
	import org.flexunit.Assert;

	//note:
	//test success:(rowIndex:3;colIndex:0 with initial bitboard.)
	public class PawnVOTest extends ChessVOTestBase
	{		
		public function PawnVOTest()
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
			this.colIndexTest = 0;
			this.rowIndexTest = 3;
			this.iChessVO = new PawnVO(9,10,rowIndexTest,colIndexTest,CcjConstants.FLAG_BLUE);
		}
		//
		[Test(descrption="PawnVO occuipes test")]
		override public function occuipes():void
		{
			var occuipesExpect:BitBoard = new BitBoard(9,10);
			occuipesExpect.setBitt(4,0,true);
			Assert.assertTrue(occuipesExpect.xor(iChessVO.occupies).isEmpty);
		}
		
		[Test(descrption="PawnVO moves test")]
		override public function moves():void
		{
			var movesExpect:BitBoard = new BitBoard(9,10);
			movesExpect.setBitt(4,0,true);
			Assert.assertTrue(movesExpect.xor(iChessVO.moves).isEmpty);
		}
		
		[Test(descrption="PawnVO captures test")]
		override public function captures():void
		{
			var capturesExpect:BitBoard = new BitBoard(9,10);
			Assert.assertTrue(capturesExpect.xor(iChessVO.captures).isEmpty);
		}
		
		
		
	}
}