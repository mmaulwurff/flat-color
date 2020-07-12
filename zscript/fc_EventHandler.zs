/* Copyright Alexander 'm8f' Kromm (mmaulwurff@gmail.com) 2020
 *
 * This file is a part of Flat Color.
 *
 * Flat Color is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * Flat Color is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Flat Color.  If not, see <https://www.gnu.org/licenses/>.
 */

class fc_EventHandler : EventHandler
{

  override
  void WorldThingSpawned(WorldEvent event)
  {
    let thing = event.thing;
    if (thing == NULL)
    {
      return;
    }

    thing.A_SetRenderStyle(thing.alpha, STYLE_Stencil);

    String shade = "0000FF";
    if      (thing.bIsMonster)      shade = "FF0000";
    else if (thing is "Inventory")  shade = "00FF00";
    else if (thing is "Blood")      shade = "000000";
    else if (thing is "BulletPuff") shade = "FFFFFF";

    thing.SetShade(shade);
  }

  override
  void WorldLoaded(WorldEvent event)
  {
    uint nLines = Level.Lines.size();
    for (uint i = 0; i < nLines; ++i)
    {
      Line l = Level.Lines[i];

      if (l.activation & SPAC_Use
          || l.activation & SPAC_Impact
          || l.activation & SPAC_Push
          || l.activation & SPAC_UseThrough)
      {
        for (int part = Side.Top; part <= Side.Bottom; ++part)
        {
          for (int s = 0; s < 2; ++s)
          {
            if (l.sidedef[s])
            {
              l.sidedef[s].setAdditiveColor(part, "00FFFF");
              l.sidedef[s].enableAdditiveColor(part, true);
            }
          }
        }
      }
    }

    uint nSides = Level.Sides.size();
    for (uint i = 0; i < nSides; ++i)
    {
      Side s = Level.Sides[i];
      s.light /= 2;
    }
  }

} // class fc_EventHandler
