package flexUnitTests.chessVO.tests
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.model.vos.cvo.MarshalVO;
	import com.lookbackon.ds.BitBoard;
	
	import org.flexunit.Assert;
	//note:
	//test success:(rowIndex:0/9;colIndex:4 with initial bitboard.)
	public class MarshalVOTest extends ChessVOTestBase
	{		
		public function MarshalVOTest()
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
			this.colIndexTest = 4;
			this.rowIndexTest = 9;
			this.iChessVO = new MarshalVO(9,10,rowIndexTest,colIndexTest,CcjConstants.FLAG_RED);
		}
		//
		[Test(descrption="MarshalVO occuipes test")]
		override public function occuipes():void
		{
			var occuipesExpect:BitBoard = new BitBoard(9,10);
			occuipesExpect.setBitt(9,3,true);
			occuipesExpect.setBitt(9,5,true);
			occuipesExpect.setBitt(8,4,true);
			Assert.assertTrue(occuipesExpect.xor(iChessVO.occupies).isEmpty);
		}
		
		[Test(descrption="MarshalVO moves test")]
		override public function moves():void
		{
			var movesExpect:BitBoard = new BitBoard(9,10);
			movesExpect.setBitt(8,4,true);
			Assert.assertTrue(movesExpect.xor(iChessVO.moves).isEmpty);
		}
		
		[Test(descrption="MarshalVO captures test")]
		override public function captures():void
		{
			var capturesExpect:BitBoard = new BitBoard(9,10);
			Assert.assertTrue(capturesExpect.xor(iChessVO.captures).isEmpty);
		}
		
	}
}