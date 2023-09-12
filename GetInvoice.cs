using System;

namespace Coffer_Systems
{
    internal class GetInvoice
    {
        public GetInvoice()
        {
        }

        public string id { get; internal set; }
        public string invno { get; internal set; }
        public DateTime date { get; internal set; }
        public string ticket { get; internal set; }
        public string amount { get; internal set; }
        public string credit { get; internal set; }
        public string balance { get; internal set; }
        public string name { get; internal set; }
        public string sector { get; internal set; }
        public string age { get; internal set; }
    }
}