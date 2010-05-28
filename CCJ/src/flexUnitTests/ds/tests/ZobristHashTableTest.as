package flexUnitTests.ds.tests
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.ZobristConstants;
	import com.lookbackon.ccj.model.vos.ZobristKeyVO;
	import com.lookbackon.ds.ZobristHashTable;
	
	import de.polygonal.ds.Array2;
	import de.polygonal.math.PM_PRNG;
	
	import flexunit.framework.Assert;
	
	public class ZobristHashTableTest
	{		
		private var _zobristHT:ZobristHashTable;
		private var _pm_PRNG:PM_PRNG;
		private var _zobristKeyVO:ZobristKeyVO;
		
		[Before]
		public function setUp():void
		{
			_pm_PRNG = new PM_PRNG();
			_zobristHT = new ZobristHashTable(CcjConstants.BOARD_H_LINES*CcjConstants.BOARD_V_LINES,ZobristConstants.BLUE_BISHOP.key);
			_zobristKeyVO = new ZobristKeyVO();
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
		
		[Test]
		public function testXor():void
		{
			//TODO:before xoring,after xoring test.
			_zobristKeyVO.color = new Array2(CcjConstants.BOARD_H_LINES,CcjConstants.BOARD_V_LINES);
			//ZobristConstants.BLUE_BISHOP.color;
			_zobristKeyVO.position =  new Array2(CcjConstants.BOARD_H_LINES,CcjConstants.BOARD_V_LINES);
			//ZobristConstants.BLUE_BISHOP.position;
			_zobristKeyVO.type =  new Array2(CcjConstants.BOARD_H_LINES,CcjConstants.BOARD_V_LINES);
			//ZobristConstants.BLUE_BISHOP.type;
			
			_zobristHT.insert(ZobristConstants.BLUE_BISHOP.key,_zobristKeyVO);
			_zobristHT.insert(ZobristConstants.BLUE_CANNON.key,_zobristKeyVO);
			_zobristHT.insert(ZobristConstants.BLUE_KNIGHT.key,_zobristKeyVO);
			trace(_zobristHT.dump());
			trace(_zobristHT.xor(_zobristHT).find(ZobristConstants.BLUE_BISHOP.key));
			Assert.fail("Test method Not yet implemented");
		}
	}
}