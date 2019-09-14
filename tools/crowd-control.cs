using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CrowdControl.Common;
using JetBrains.Annotations;

namespace CrowdControl.Games.Packs
{
	[UsedImplicitly]
	public class CV2R : NESEffectPack
	{
		[NotNull]
		private readonly IPlayer _player;

		public CV2R([NotNull] IPlayer player, [NotNull] Func<CrowdControlBlock, bool> responseHandler, [NotNull] Action<object> statusUpdateHandler) : base(responseHandler, statusUpdateHandler) => _player = player;

		private volatile bool _quitting = false;
		public override void Dispose()
		{
			_quitting = true;
			base.Dispose();
		}

		private const ushort ADDR_QUEST_ITEMS = 0x0091;

		private enum QuestItem : byte
		{
			Rib = 0x01,
			Heart = 0x02,
			Eye = 0x04,
			Nail = 0x08,
			Ring = 0x10,
			WhiteCrystal = 0x20,
			BlueCrystal = 0x40,
			RedCrystal = 0x60
		}

		public override List<Effect> Effects
		{
			get
			{
				List<Effect> effects = new List<Effect>
				{
					new Effect("Give Rib", "rib")
				};
				return effects;
			}
		}

		public override List<ROMInfo> ROMTable => new List<ROMInfo>(new[]
		{
			// TODO: is there a way to do the standard ROM validation check here for "CASTLE2"?
			new ROMInfo("CV2R", null, Patching.Ignore, ROMStatus.ValidPatched, s => s.Length == 262160)
		});

		public override List<(string, Action)> MenuActions => new List<(string, Action)>();

		public override Game Game { get; } = new Game(11, "CV2R", "CV2R", "NES", ConnectorType.NESConnector);

		protected override bool IsReady(EffectRequest request) => Connector.Read8(0x00b1, out byte b) && (b < 0x80);

		protected override void RequestData(DataRequest request) => Respond(request, request.Key, null, false, $"Variable name \"{request.Key}\" not known");

		protected override void StartEffect(EffectRequest request)
		{
			if (!IsReady(request))
			{
				DelayEffect(request, TimeSpan.FromSeconds(5));
				return;
			}

			string[] codeParams = request.FinalCode.Split('_');
			switch (codeParams[0])
			{
				case "rib": {
					if (!Connector.Read8(ADDR_QUEST_ITEMS, out byte questItems))
					{
						DelayEffect(request);
						return;
					}

					// if (questItems & QuestItem.Rib != 0)
					// {
					// 	return;
					// }

					TryEffect(request,
						() => Connector.Write8(ADDR_QUEST_ITEMS, (byte)(questItems | (byte)QuestItem.Rib)),
						() => true,
						() =>
						{
							Connector.SendMessage($"{request.DisplayViewer} gave you the rib.");

							// TODO: find sound effects
							// PlaySFX(SFXType.HPIncrement);
						}, TimeSpan.FromSeconds(1));
					return;
				}
			}
		}

		protected override bool StopEffect(EffectRequest request)
		{
			return false;
		}

		public override bool StopAllEffects() => base.StopAllEffects() && Connector.Write8(0x8904, 0x29) && Connector.Write8(0xd3c8, 0x00);
	}
}